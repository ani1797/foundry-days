# Day 2 workflow ledger

## Checkpoint 1 - infra & env (lead, 2026-11-15): PASS
Evidence (live checks):
- `az bicep build` OK (only BCP081 no-type-definition warnings for preview API versions).
- rg-foundry-day2 live: Foundry account + project maple-mortgage, Search, ACR, App Insights, Log Analytics; all tagged purpose=foundry-days-day2.
- Entra-only: Foundry and Search `disableLocalAuth: true`; ACR admin user disabled (verified live false).
- Deployments gpt-4.1-mini and text-embedding-3-small Succeeded.
- Data plane with my token: project /deployments HTTP 200, Search /indexes HTTP 200.
- `.env` generated, git-ignored, not tracked; `.env.example` has no values/secrets; scripts deploy/write-env/teardown exist. Env contract matches spec plus architect additions.
Notes / risks:
- Search is in eastus (eastus2 had no capacity); cross-region, document in setup-notes.
- `.env` contains the App Insights connection string (ingestion key); acceptable, git-ignored; never print in notebook outputs.
- KB/knowledge source objects, agent runtime, and Search agentic retrieval in eastus not yet verified (notebook 03 risk).
- Only .sh scripts exist (spec allows .ps1|.sh). No stalled tasks seen (infra task done same session).
Downstream notebook tasks released.
