param location string
param tags object
param name string

resource acr 'Microsoft.ContainerRegistry/registries@2026-11-01' = {
  name: name
  location: location
  tags: tags
  sku: { name: 'Basic' }
  properties: {
    adminUserEnabled: false
  }
}

output id string = acr.id
output name string = acr.name
output loginServer string = acr.properties.loginServer
