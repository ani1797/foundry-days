# Day 2 build spec (source of truth for all workers)

Repo: `C:/Users/aniaggarwal/Projects/foundry-days`, branch `day-2-build`. Work ONLY under `day-2/` (plus the paths your task names). Pattern to mimic: `C:/Users/aniaggarwal/Projects/how-to/build-with-microsoft-agent-framework` (numbered notebooks, README table, pyproject.toml, `.env.example`, `.gitignore`, `uv sync`, `az login`, no API keys, `DefaultAzureCredential`, each notebook: title + "What you'll learn" + Setup cell + demo cells + Key Takeaways + "Next up" link). Read 2-3 of those notebooks first.

## Goal
Hands-on Day 2 for an FSI audience (banks, insurers, mortgage lenders): learners run notebooks and see each concept work.
Topics: (1) build an agent - prompt-based and hosted; (2) agent with Foundry IQ / tools / MCP; (3) knowledge base + memory; (4) skills + skills registry; (5) evaluation + traces; (6) deployment.
Stack: Microsoft Agent Framework (Python), Azure AI Projects SDK (`azure-ai-projects`) for Foundry account/project, Azure Bicep for infra.

## Running case study (FSI): "Maple Mortgage Assistant" for a fictional lender, Northwind Home Lending
Personas: loan officer / borrower. Domain: mortgage pre-qualification, rate quotes, document checklists, policy Q&A, escalation to human underwriter. Use only fictional data. Include a compliance flavour (no rate promises, disclosures, PII handling, audit trail).

## Layout (day-2/)
```
README.md                 (lead owns; update existing)
pyproject.toml  .env.example  .gitignore  (architect/infra own)
bicep/main.bicep + modules/ + main.bicepparam + README.md      (system-engineer)
scripts/deploy.ps1|.sh, teardown.ps1|.sh, write-env.*           (system-engineer)
data/                     fictional FSI corpus: policies/*.md, rates.json, customers.json, eval dataset  (data-scientist)
shared/                   helper module `fsi_common.py` (env loading, client factory, mock mortgage tools)  (architect defines API, software-engineer writes)
skills/                   Agent Skills folders (SKILL.md each) + registry index  (integrations-engineer)
notebooks/01-build-an-agent.ipynb            prompt agent (Foundry Agent Service) + hosted agent concept (software-engineer)
notebooks/02-tools-and-mcp.ipynb             function tools, MCP (Learn MCP + local MCP server), Foundry tools   (software-engineer)
notebooks/03-foundry-iq-knowledge.ipynb      Azure AI Search index + Foundry IQ knowledge base grounding         (integrations-engineer)
notebooks/04-memory.ipynb                    sessions + Foundry memory store / long-term memory                   (integrations-engineer)
notebooks/05-skills-and-registry.ipynb       Agent Skills, loading from a registry                                (integrations-engineer)
notebooks/06-evaluation-and-traces.ipynb     OpenTelemetry traces to App Insights, Foundry evaluators, dataset runs (data-scientist)
notebooks/07-deploy-hosted-agent.ipynb       containerize + deploy hosted agent / API, versioning, release gate   (software-engineer)
hosted-agent/             Dockerfile + main.py (agent served via Agent Framework hosting / Responses protocol)     (software-engineer)
templates/ docs/          existing; lead refreshes
```

## Env contract (`.env.example`, written by `scripts/write-env`)
`AZURE_AI_PROJECT_ENDPOINT`, `AZURE_AI_MODEL_DEPLOYMENT_NAME` (chat model), `AZURE_AI_EMBEDDING_DEPLOYMENT_NAME`, `AZURE_SEARCH_ENDPOINT`, `AZURE_SEARCH_INDEX_NAME`, `APPLICATIONINSIGHTS_CONNECTION_STRING`, `AZURE_RESOURCE_GROUP`, `AZURE_SUBSCRIPTION_ID`, `AZURE_LOCATION`. Auth: Entra only (`DefaultAzureCredential`); local auth disabled. No keys/secrets anywhere in repo, outputs, logs or notebooks.

## Rules
- Verify every API against the CURRENT released packages and docs (learn.microsoft.com/agent-framework, azure-ai-projects docs/samples on GitHub) - do not guess class names. Pin versions that you actually ran in `pyproject.toml`.
- Package installs: this machine has a private feed configured and `uv` hits SSL HandshakeFailure on files.pythonhosted.org. Use `uv ... --index-url https://pypi.org/simple`, or `pip` via `C:/Python314`, or other fix; document what works in `docs/setup-notes.md`.
- A notebook is "done" only after it was executed top to bottom against the live deployed environment with no errors (`jupyter nbconvert --execute --to notebook --inplace` or papermill). Strip secrets from outputs; commit outputs only from a live run.
- Notebooks need an "Optional/offline" note where a feature needs a preview capability; if a capability is unavailable in the region/tenant, say so in the notebook and in `docs/setup-notes.md` rather than faking output.
- Never print/commit keys, tokens, connection strings with keys. `.env` is git-ignored.
- Git: commit on branch `day-2-build` only, `git add <your specific paths>` (never `-a`), small commits. Do not push. Git: use `C:/Program Files/Git/cmd/git.exe` (the bundled git in PATH is access-denied; prefix `export PATH="/c/Program Files/Git/cmd:$PATH"`).
- Azure: sandbox subscription is the logged-in `az` account (tenant Caldova). One resource group `rg-foundry-day2`. All resources must be tagged `purpose=foundry-days-day2`. Teardown is a final task: nothing is deleted before the lead's acceptance.
- Keep content concise, learner-friendly: short markdown, one concept per section, visible result after each demo cell.
