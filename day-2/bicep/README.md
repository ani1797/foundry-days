# Day 2 infrastructure (Bicep)

Deploys into `rg-foundry-day2` (eastus2): Foundry account (AIServices, Entra-only, local auth disabled) + project `maple-mortgage`,
`gpt-4.1-mini` and `text-embedding-3-small` (GlobalStandard), Azure AI Search (basic, in `searchLocation`=eastus because eastus2 had no capacity),
Log Analytics + Application Insights, ACR, project connections (search, App Insights, KB MCP), and role assignments. Tag: `purpose=foundry-days-day2`.

## Layout
`main.bicep` + `main.bicepparam` (no secrets) and `modules/` (foundry, search, monitoring, acr, roles).

## Use
```bash
export USER_PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
bash day-2/scripts/deploy.sh --yes   # what-if first, then create; ~10 min; re-runnable (idempotent); writes day-2/.env
bash day-2/scripts/write-env.sh      # regenerate day-2/.env from deployment outputs
bash day-2/scripts/teardown.sh       # DESTRUCTIVE: deletes the RG, purges the soft-deleted account, prints verification
```
Without `--yes`, deploy.sh stops after what-if.

## Roles (deploying user)
Azure AI User, Cognitive Services OpenAI User (account); Search Index Data Contributor + Search Service Contributor (search); AcrPush (ACR); Monitoring Reader (App Insights).
Project/account/search identities get Search Index Data Reader, AcrPull and OpenAI User as needed.

## Notes
- Output keys come back with mangled casing from ARM; write-env.sh matches case-insensitively.
- The project depends on the model deployments (otherwise RequestConflict).
- Rollback: teardown.sh. Cost: Search basic (~$75/mo) is the main fixed cost; delete when done.
