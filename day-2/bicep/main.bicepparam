using 'main.bicep'

// userPrincipalId is supplied by scripts/deploy (signed-in user object id). Not a secret.
param userPrincipalId = readEnvironmentVariable('USER_PRINCIPAL_ID', '')
param location = 'eastus2'
param tags = { purpose: 'foundry-days-day2' }
// eastus2 had no Search capacity (InsufficientResourcesAvailable) at deploy time
param searchLocation = 'eastus'
param namePrefix = 'fd2'
param projectName = 'maple-mortgage'
param chatModelName = 'gpt-4.1-mini'
param chatModelVersion = '2025-04-14'
param chatCapacity = 50
param embeddingModelName = 'text-embedding-3-small'
param embeddingModelVersion = '1'
param embeddingCapacity = 50
