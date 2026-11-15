# Changes (architect, 2026-11-15) - spec vs reality

Evidence: `docs/setup-notes.md`, recon report (task t_e48c5d38), `docs/architecture.md`, `docs/notebook-outlines.md`. These override the text below.

1. **Packages:** `uv sync` fails here (SSL HandshakeFailure). Use venv + pip (`C:/Python314/python.exe -m venv .venv`, then `pip install --pre` the pins listed in `pyproject.toml`). Pins in `pyproject.toml` are the versions actually installed. Do not use the `agent-framework` meta-package.
2. **Prereleases:** `agent-framework-foundry-hosting` and `agent-framework-azure-ai-search` are prerelease (pinned). Memory stores, Skills API, Foundry IQ KB MCP, FoundryEvals are preview/experimental: add the "Optional/unavailable" note, never fake output.
3. **Env names:** AF reads `FOUNDRY_PROJECT_ENDPOINT`/`FOUNDRY_MODEL`, not the spec's `AZURE_AI_*`. Keep spec names in `.env`; `fsi_common` passes `project_endpoint=`/`model=` explicitly. Added vars: `AZURE_SEARCH_KNOWLEDGE_BASE_NAME`, `AZURE_AI_KB_CONNECTION_NAME`, `AZURE_CONTAINER_REGISTRY_NAME`. `write-env` must emit them.
4. **No Docker on this machine:** hosted agent deploy uses `create_version_from_code` or `az acr build`, not `docker build`.
5. **Region/models:** East US 2; chat `gpt-4.1-mini`, embedding `text-embedding-3-small`, both GlobalStandard. Foundry basic agent setup (no capability host). Bicep API versions: see `architecture.md` (CognitiveServices 2026-11-01, Search 2025-05-01, ACR 2026-11-01, AppInsights 2020-02-02).
6. **Helper API:** `shared/fsi_common.py` signatures are fixed in `notebook-outlines.md`; do not change without the architect.
7. **Deps for notebooks:** `ipykernel`, `nbconvert`, `nbclient` pinned for `jupyter nbconvert --execute`. Python 3.14 venv, `requires-python >=3.12`.
8. **Teardown:** also purge the soft-deleted Foundry account.
9. Not verified live as of this note: every call against a Foundry project, quota, Search agentic-retrieval availability in East US 2.

---

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
