// Role assignments (resource-scoped, least privilege).
param userPrincipalId string
param projectPrincipalId string
param accountPrincipalId string
param searchPrincipalId string
param accountName string
param searchName string
param acrName string
param appInsightsName string

var roles = {
  azureAIUser: '53ca6127-db72-4b80-b1b0-d745d6d5456d'
  openAIUser: '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd'
  searchIndexDataContributor: '8ebe5a00-799e-43f5-93ac-243d3dce84a7'
  searchIndexDataReader: '1407120a-92aa-4202-b7e9-c0e197c71c8f'
  searchServiceContributor: '7ca78c08-252a-4471-8644-bb5ff32d4ba0'
  acrPush: '8311e382-0749-4cb8-b61a-304f252e45ec'
  acrPull: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
  monitoringReader: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
}

resource account 'Microsoft.CognitiveServices/accounts@2026-11-01' existing = { name: accountName }
resource search 'Microsoft.Search/searchServices@2025-05-01' existing = { name: searchName }
resource acr 'Microsoft.ContainerRegistry/registries@2026-11-01' existing = { name: acrName }
resource appi 'Microsoft.Insights/components@2020-02-02' existing = { name: appInsightsName }

func rid(role string) string => subscriptionResourceId('Microsoft.Authorization/roleDefinitions', role)

// Deploying user (skipped when no principal id is given)
resource uAi 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, userPrincipalId, roles.azureAIUser)
  scope: account
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.azureAIUser) }
}
resource uOai 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, userPrincipalId, roles.openAIUser)
  scope: account
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.openAIUser) }
}
resource uSidc 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(search.id, userPrincipalId, roles.searchIndexDataContributor)
  scope: search
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.searchIndexDataContributor) }
}
resource uSsc 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(search.id, userPrincipalId, roles.searchServiceContributor)
  scope: search
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.searchServiceContributor) }
}
resource uAcr 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acr.id, userPrincipalId, roles.acrPush)
  scope: acr
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.acrPush) }
}
resource uMon 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(appi.id, userPrincipalId, roles.monitoringReader)
  scope: appi
  properties: { principalId: userPrincipalId, principalType: 'User', roleDefinitionId: rid(roles.monitoringReader) }
}

// Project identity: KB MCP connection (ProjectManagedIdentity) reads Search; pulls images
resource pSidr 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(search.id, 'project-identity', roles.searchIndexDataReader)
  scope: search
  properties: { principalId: projectPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.searchIndexDataReader) }
}
resource pAcr 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acr.id, 'project-identity', roles.acrPull)
  scope: acr
  properties: { principalId: projectPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.acrPull) }
}
// Account identity
resource aSidr 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(search.id, 'account-identity', roles.searchIndexDataReader)
  scope: search
  properties: { principalId: accountPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.searchIndexDataReader) }
}
resource aAcr 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acr.id, 'account-identity', roles.acrPull)
  scope: acr
  properties: { principalId: accountPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.acrPull) }
}
// Search identity -> Foundry models (KB query planning, embedding vectorizer)
resource sOai 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, 'search-identity', roles.openAIUser)
  scope: account
  properties: { principalId: searchPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.openAIUser) }
}
// Foundry memory store: project + account identities call the embedding deployment (local auth is off)
resource pOai 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, 'project-identity', roles.openAIUser)
  scope: account
  properties: { principalId: projectPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.openAIUser) }
}
resource aOai 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, 'account-identity', roles.openAIUser)
  scope: account
  properties: { principalId: accountPrincipalId, principalType: 'ServicePrincipal', roleDefinitionId: rid(roles.openAIUser) }
}
