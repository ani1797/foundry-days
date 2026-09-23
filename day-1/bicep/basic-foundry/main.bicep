// Day 1 asset — Basic Microsoft Foundry setup (public network, managed identity)
// Use for dev/sandbox exploration only. Not suitable for regulated FSI workloads —
// see network-isolated-foundry/ or hub-spoke-foundry/ for production patterns.

@description('Name of the Foundry account')
param foundryAccountName string

@description('Azure region for the deployment')
param location string = resourceGroup().location

@description('SKU for the Foundry account')
param skuName string = 'S0'

resource foundryAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: foundryAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'AIServices'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    customSubDomainName: foundryAccountName
    publicNetworkAccess: 'Enabled' // TBD: confirm acceptable for target environment
    disableLocalAuth: true
  }
}

resource foundryProject 'Microsoft.CognitiveServices/accounts/projects@2024-10-01' = {
  parent: foundryAccount
  name: '${foundryAccountName}-project'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

output foundryAccountId string = foundryAccount.id
output foundryProjectId string = foundryProject.id
