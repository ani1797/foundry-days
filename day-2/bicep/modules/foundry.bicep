param location string
param tags object
param accountName string
param projectName string
param chatModelName string
param chatModelVersion string
param chatCapacity int
param embeddingModelName string
param embeddingModelVersion string
param embeddingCapacity int
param searchName string
param appInsightsName string
param kbConnectionName string
param kbName string
param kbApiVersion string

resource account 'Microsoft.CognitiveServices/accounts@2026-11-01' = {
  name: accountName
  location: location
  tags: tags
  kind: 'AIServices'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: {
    customSubDomainName: accountName
    allowProjectManagement: true
    disableLocalAuth: true
    publicNetworkAccess: 'Enabled'
  }
}

resource project 'Microsoft.CognitiveServices/accounts/projects@2026-11-01' = {
  parent: account
  name: projectName
  dependsOn: [ embedding ] // control-plane ops on one account are serialized
  location: location
  tags: tags
  identity: { type: 'SystemAssigned' }
  properties: {
    displayName: 'Foundry Days - Day 2'
    description: 'Maple Mortgage Assistant workshop project'
  }
}

resource chat 'Microsoft.CognitiveServices/accounts/deployments@2026-11-01' = {
  parent: account
  name: chatModelName
  sku: { name: 'GlobalStandard', capacity: chatCapacity }
  properties: {
    model: { format: 'OpenAI', name: chatModelName, version: chatModelVersion }
  }
}

// Deployments on one account must be serialized.
resource embedding 'Microsoft.CognitiveServices/accounts/deployments@2026-11-01' = {
  parent: account
  name: embeddingModelName
  dependsOn: [ chat ]
  sku: { name: 'GlobalStandard', capacity: embeddingCapacity }
  properties: {
    model: { format: 'OpenAI', name: embeddingModelName, version: embeddingModelVersion }
  }
}

resource appi 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

resource appiConn 'Microsoft.CognitiveServices/accounts/projects/connections@2026-11-01' = {
  parent: project
  name: 'appinsights'
  properties: {
    category: 'AppInsights'
    target: appi.id
    authType: 'ApiKey'
    isSharedToAll: true
    credentials: { key: appi.properties.ConnectionString }
    metadata: { ApiType: 'Azure', ResourceId: appi.id }
  }
}

resource searchConn 'Microsoft.CognitiveServices/accounts/projects/connections@2026-11-01' = {
  parent: project
  name: 'search'
  properties: {
    category: 'CognitiveSearch'
    target: 'https://${searchName}.search.windows.net'
    authType: 'AAD'
    isSharedToAll: true
    metadata: { ApiType: 'Azure', ResourceId: resourceId('Microsoft.Search/searchServices', searchName), location: location }
  }
}

resource kbConn 'Microsoft.CognitiveServices/accounts/projects/connections@2026-11-01' = {
  parent: project
  name: kbConnectionName
  properties: {
    category: 'RemoteTool'
    target: 'https://${searchName}.search.windows.net/knowledgebases/${kbName}/mcp?api-version=${kbApiVersion}'
    authType: 'ProjectManagedIdentity'
    isSharedToAll: true
    audience: 'https://search.azure.com/'
    metadata: { ApiType: 'Azure' }
  }
}

output accountId string = account.id
output accountName string = account.name
output accountPrincipalId string = account.identity.principalId
output projectName string = project.name
output projectPrincipalId string = project.identity.principalId
output projectEndpoint string = 'https://${account.name}.services.ai.azure.com/api/projects/${project.name}'
