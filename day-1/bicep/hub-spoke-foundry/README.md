# Hub-and-Spoke Foundry Setup

Enterprise landing-zone pattern: a shared hub VNET (DNS, firewall, egress) with one or more spoke VNETs hosting Foundry accounts/projects per business unit or workload. Builds on `network-isolated-foundry/` and adds the hub-spoke peering/routing layer covered in this session's landing-zone design block.

**Deploy (spoke, per workload):**
```bash
az deployment group create \
  --resource-group <spoke-rg-name> \
  --template-file main.bicep \
  --parameters foundryAccountName=<name> location=<region> \
               spokeVnetId=<spoke-vnet-resource-id> \
               privateEndpointSubnetId=<spoke-subnet-resource-id> \
               privateDnsZoneId=<hub-private-dns-zone-resource-id> \
               hubFirewallPrivateIp=<hub-azfw-private-ip>
```

Assumes the hub (firewall, DNS resolver, peering) is already deployed separately as part of the shared landing-zone platform — that hub template is out of scope for this per-workload spoke template.
