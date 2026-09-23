# Basic Foundry Setup

Public network access, managed-identity-based auth, no VNET integration. Suitable for dev/sandbox exploration only — not for regulated workloads.

**Deploy:**
```bash
az deployment group create \
  --resource-group <rg-name> \
  --template-file main.bicep \
  --parameters foundryAccountName=<name> location=<region>
```
