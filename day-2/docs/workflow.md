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

## Checkpoint 2 - notebooks 01-06, data, skills, shared (lead, 2026-11-16): PASS
Evidence:
- nb01-06 committed on day-2-build (latest 4f82115); every code cell has an execution count and saved output; 0 error outputs; secret-pattern scan (InstrumentationKey, Bearer, sk-, JWT, AccountKey) found 0 hits.
- Worker reports: each notebook re-executed live end to end; nb03-07 and nb01-02 build agents inline, register Foundry assets, then clean up with asserts. nb06 gate: v1 PASS, v2 BLOCKED.
- Data/skills: fictional Northwind/Maple FSI corpus, rates, customers, eval set (n=37); 3 approved skills + one deliberately unapproved.
Notes / risks (non-blocking):
1. Commits unsigned (1Password signing fails); acceptable, state in PR.
2. Untracked scratch `day-2/_*.py/_*.log`, `.team/`, and uncommitted `sample-agent/` deletions: clean before final PR.
3. Concurrent runs hit 429/401 on model and embedding deployments; run notebooks serially in final fresh-clone test.
4. nb06 eval is small (n=37), same-family judge; block rests on one deterministic miss. Disclose in the notebook.
5. nb03 keeps shared Search index/KB unless TEARDOWN_SHARED=True; toolbox in nb05 not attached to an agent.
6. nb07 rebuild is ~8 min (ACR build); schedule time in the rehearsal.
7. Stalled tasks: none >60 min observed. nb07 already built and executed; no rescoping needed.
