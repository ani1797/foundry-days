#!/usr/bin/env bash
# Deploy day-2 infra into rg-foundry-day2: what-if first, then create. Idempotent.
# Usage: scripts/deploy.sh [--yes]   (--yes skips the confirmation prompt)
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && { pwd -W 2>/dev/null || pwd; })"
RG="${AZURE_RESOURCE_GROUP:-rg-foundry-day2}"
LOC="${AZURE_LOCATION:-eastus2}"

SUB="$(az account show --query id -o tsv)"
echo "Subscription: $SUB ($(az account show --query name -o tsv))"
export USER_PRINCIPAL_ID="$(az ad signed-in-user show --query id -o tsv)"

az group create -n "$RG" -l "$LOC" --tags purpose=foundry-days-day2 -o none
echo "== what-if =="
az deployment group what-if -g "$RG" -f "$HERE/bicep/main.bicep" -p "$HERE/bicep/main.bicepparam"

if [[ "${1:-}" != "--yes" ]]; then
  read -r -p "Proceed with deployment? [y/N] " ans
  [[ "$ans" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
fi

az deployment group create -g "$RG" -n foundry-day2 -f "$HERE/bicep/main.bicep" -p "$HERE/bicep/main.bicepparam" \
  --query properties.provisioningState -o tsv
"$HERE/scripts/write-env.sh"
