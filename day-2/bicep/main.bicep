targetScope = 'resourceGroup'

@description('Azure region.')
param location string = resourceGroup().location
@description('Entra object id of the deploying user (gets data-plane roles).')
param userPrincipalId string
param tags object = { purpose: 'foundry-days-day2' }
@description('Short prefix for resource names.')
param searchLocation string = location
param namePrefix string = 'fd2'
param projectName string = 'maple-mortgage'
param chatModelName string = 'gpt-4.1-mini'
param chatModelVersion string = '2025-04-14'
param chatCapacity int = 50
param embeddingModelName string = 'text-embedding-3-small'
param embeddingModelVersion string = '1'
param embeddingCapacity int = 50
param searchIndexName string = 'northwind-policies'
param kbName string = 'northwind-kb'
param kbConnectionName string = 'northwind-kb-mcp'
param kbApiVersion string = '2026-08-01-preview'

var suffix = uniqueString(resourceGroup().id)
var accountName = '${namePrefix}-foundry-${suffix}'
var searchName = '${namePrefix}-search-${suffix}'
var acrName = '${namePrefix}acr${suffix}'

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoring'
  params: {
    location: location
    tags: tags
    workspaceName: '${namePrefix}-law-${suffix}'
    appInsightsName: '${namePrefix}-appi-${suffix}'
  }
}

module search 'modules/search.bicep' = {
  name: 'search'
  params: { location: searchLocation, tags: tags, name: searchName }
}

module acr 'modules/acr.bicep' = {
  name: 'acr'
  params: { location: location, tags: tags, name: acrName }
}

module foundry 'modules/foundry.bicep' = {
  name: 'foundry'
  params: {
    location: location
    tags: tags
    accountName: accountName
    projectName: projectName
    chatModelName: chatModelName
    chatModelVersion: chatModelVersion
    chatCapacity: chatCapacity
    embeddingModelName: embeddingModelName
    embeddingModelVersion: embeddingModelVersion
    embeddingCapacity: embeddingCapacity
    searchName: search.outputs.name
    appInsightsName: monitoring.outputs.appInsightsName
    kbConnectionName: kbConnectionName
    kbName: kbName
    kbApiVersion: kbApiVersion
  }
}

module roles 'modules/roles.bicep' = {
  name: 'roles'
  params: {
    userPrincipalId: userPrincipalId
    projectPrincipalId: foundry.outputs.projectPrincipalId
    accountPrincipalId: foundry.outputs.accountPrincipalId
    searchPrincipalId: search.outputs.principalId
    accountName: foundry.outputs.accountName
    searchName: search.outputs.name
    acrName: acr.outputs.name
    appInsightsName: monitoring.outputs.appInsightsName
  }
}

output AZURE_AI_PROJECT_ENDPOINT string = foundry.outputs.projectEndpoint
output AZURE_AI_MODEL_DEPLOYMENT_NAME string = chatModelName
output AZURE_AI_EMBEDDING_DEPLOYMENT_NAME string = embeddingModelName
output AZURE_SEARCH_ENDPOINT string = search.outputs.endpoint
output AZURE_SEARCH_INDEX_NAME string = searchIndexName
output AZURE_SEARCH_KNOWLEDGE_BASE_NAME string = kbName
output AZURE_AI_KB_CONNECTION_NAME string = kbConnectionName
output AZURE_CONTAINER_REGISTRY_NAME string = acr.outputs.name
output AZURE_LOCATION string = location
output FOUNDRY_ACCOUNT_NAME string = foundry.outputs.accountName
output APPINSIGHTS_NAME string = monitoring.outputs.appInsightsName
