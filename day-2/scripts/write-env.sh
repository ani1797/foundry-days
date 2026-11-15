#!/usr/bin/env bash
# Generate day-2/.env from the latest deployment outputs. No keys: Entra auth only.
# The App Insights connection string is read from the resource (contains an ingestion key; .env is git-ignored).
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && { pwd -W 2>/dev/null || pwd; })"
RG="${AZURE_RESOURCE_GROUP:-rg-foundry-day2}"
DEP="${DEPLOYMENT_NAME:-foundry-day2}"

out() { az deployment group show -g "$RG" -n "$DEP" --query "properties.outputs.$1.value" -o tsv | tr -d '\r'; }
APPI="$(out APPINSIGHTS_NAME)"
CS="$(az monitor app-insights component show -g "$RG" -a "$APPI" --query connectionString -o tsv | tr -d '\r')"

cat > "$HERE/.env" <<EOF
AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv | tr -d '\r')
AZURE_RESOURCE_GROUP=$RG
AZURE_LOCATION=$(out AZURE_LOCATION)
AZURE_AI_PROJECT_ENDPOINT=$(out AZURE_AI_PROJECT_ENDPOINT)
AZURE_AI_MODEL_DEPLOYMENT_NAME=$(out AZURE_AI_MODEL_DEPLOYMENT_NAME)
AZURE_AI_EMBEDDING_DEPLOYMENT_NAME=$(out AZURE_AI_EMBEDDING_DEPLOYMENT_NAME)
AZURE_SEARCH_ENDPOINT=$(out AZURE_SEARCH_ENDPOINT)
AZURE_SEARCH_INDEX_NAME=$(out AZURE_SEARCH_INDEX_NAME)
AZURE_SEARCH_KNOWLEDGE_BASE_NAME=$(out AZURE_SEARCH_KNOWLEDGE_BASE_NAME)
AZURE_AI_KB_CONNECTION_NAME=$(out AZURE_AI_KB_CONNECTION_NAME)
APPLICATIONINSIGHTS_CONNECTION_STRING=$CS
AZURE_CONTAINER_REGISTRY_NAME=$(out AZURE_CONTAINER_REGISTRY_NAME)
EOF
echo "Wrote $HERE/.env (keys shown only by name):"; cut -d= -f1 "$HERE/.env"
