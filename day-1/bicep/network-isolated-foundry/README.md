# Network-Isolated Foundry Setup

Private endpoints + VNET injection, no public ingress/egress. This is the standard production pattern for FSI/regulated customers covered in this session's connectivity walkthrough.

**Deploy:**
```bash
az deployment group create \
  --resource-group <rg-name> \
  --template-file main.bicep \
  --parameters foundryAccountName=<name> location=<region> \
               vnetId=<existing-vnet-resource-id> \
               privateEndpointSubnetId=<subnet-resource-id> \
               privateDnsZoneId=<existing-private-dns-zone-resource-id>
```

Requires a pre-existing hub or spoke VNET, subnet delegated for private endpoints, and private DNS zone(s) for `privatelink.cognitiveservices.azure.com` and `privatelink.openai.azure.com` — see the session's connectivity-patterns block for DNS/routing details.
