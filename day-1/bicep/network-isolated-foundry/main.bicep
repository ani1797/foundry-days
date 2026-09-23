// Day 1 asset — Network-isolated Microsoft Foundry setup (private endpoints, VNET injection)
// Standard production pattern for FSI/regulated customers. Requires an existing VNET,
// private-endpoint subnet, and private DNS zone(s) — values below marked TBD must be
// supplied per customer environment.

@description('Name of the Foundry account')
param foundryAccountName string

@description('Azure region for the deployment')
param location string = resourceGroup().location

@description('SKU for the Foundry account')
param skuName string = 'S0'

@description('Resource ID of the existing subnet to attach the private endpoint to')
param privateEndpointSubnetId string // TBD: supply per environment

@description('Resource ID of the existing private DNS zone for privatelink.cognitiveservices.azure.com')
param privateDnsZoneId string // TBD: supply per environment

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
    publicNetworkAccess: 'Disabled'
    disableLocalAuth: true
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: '${foundryAccountName}-pe'
  location: location
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${foundryAccountName}-plsc'
        properties: {
          privateLinkServiceId: foundryAccount.id
          groupIds: [
            'account'
          ]
        }
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  parent: privateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
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
output privateEndpointId string = privateEndpoint.id
