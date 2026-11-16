#!/usr/bin/env bash
# DESTRUCTIVE: deletes rg-foundry-day2 and purges the soft-deleted Foundry account.
# Usage: scripts/teardown.sh [--yes]
set -euo pipefail
RG="${AZURE_RESOURCE_GROUP:-rg-foundry-day2}"

if [[ "${1:-}" != "--yes" ]]; then
  read -r -p "Delete resource group $RG and purge soft-deleted accounts? Type the RG name: " ans
  [[ "$ans" == "$RG" ]] || { echo "Aborted."; exit 1; }
fi

# Capture account name/location before deletion (needed for purge)
mapfile -t ACCTS < <(az cognitiveservices account list -g "$RG" --query "[].[name,location]" -o tsv 2>/dev/null | tr -d '\r' || true)

az group delete -n "$RG" --yes
for line in "${ACCTS[@]:-}"; do
  [[ -z "$line" ]] && continue
  name="$(echo "$line" | cut -f1)"; loc="$(echo "$line" | cut -f2)"
  echo "Purging soft-deleted account $name ($loc)"
  az cognitiveservices account purge -g "$RG" -n "$name" -l "$loc"
done

echo "== verify =="
echo "Resource group still present?"; az group list --query "[?name=='$RG'].name" -o tsv
echo "Soft-deleted accounts:"; az cognitiveservices account list-deleted --query "[?contains(id,'$RG')].name" -o tsv
