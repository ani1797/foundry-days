// Day 1 asset — Hub-and-spoke Microsoft Foundry setup (spoke template)
// Deploys a network-isolated Foundry account/project into a spoke VNET that is peered
// to a pre-existing hub (DNS resolver, Azure Firewall, ExpressRoute/VPN). The hub itself
// is deployed once per landing zone and is out of scope for this template.

@description('Name of the Foundry account')
param foundryAccountName string

@description('Azure region for the deployment')
param location string = resourceGroup().location

@description('SKU for the Foundry account')
param skuName string = 'S0'

@description('Resource ID of the spoke subnet to attach the private endpoint to')
param privateEndpointSubnetId string // TBD: supply per spoke environment

@description('Resource ID of the hub-managed private DNS zone for privatelink.cognitiveservices.azure.com')
param privateDnsZoneId string // TBD: supply per landing zone

@description('Private IP of the hub Azure Firewall used for forced-tunneled egress')
param hubFirewallPrivateIp string // TBD: supply per landing zone, used for outbound route documentation

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
// Documented for reference in the session's outbound-connectivity walkthrough;
// forced-tunneled egress is configured via the spoke route table (not deployed here).
output hubFirewallPrivateIpReference string = hubFirewallPrivateIp
