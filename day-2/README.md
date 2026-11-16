# Day 2 — Build and Deploy an Agent

**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-1](../day-1/README.md) · Next: [day-3](../day-3/README.md)

Hands-on notebooks that take one agent, the **Maple Mortgage Assistant**, from first prompt to a gated, versioned, hosted deployment on Microsoft Foundry. Every notebook runs against a real Foundry project, shows a visible result after each step, and cleans up the Foundry assets it creates.

## Case study (fictional)

**Northwind Home Lending** wants an assistant for loan officers and borrowers: mortgage pre-qualification, rate quotes, document checklists, policy Q&A and escalation to a human underwriter. Compliance is built in: no rate promises, required disclosures, PII handling and an audit trail. All data is fictional (`data/`).

## Notebooks

| # | Notebook | What you'll learn |
|---|----------|-------------------|
| 01 | [Build an agent](notebooks/01-build-an-agent.ipynb) | Code agent with Agent Framework, streaming, sessions, prompt agent registered in Foundry, local Responses host |
| 02 | [Tools and MCP](notebooks/02-tools-and-mcp.ipynb) | Function tools, approval gates, Learn MCP, local MCP server, server-side MCP tool, connections, toolbox |
| 03 | [Foundry IQ knowledge](notebooks/03-foundry-iq-knowledge.ipynb) | Azure AI Search index, knowledge source and knowledge base, grounded answers with citations |
| 04 | [Memory](notebooks/04-memory.ipynb) | Short-term sessions, Foundry memory store, scope isolation, right-to-erasure |
| 05 | [Skills and registry](notebooks/05-skills-and-registry.ipynb) | Agent Skills, approved-skills registry with hash pinning, Foundry skills and toolbox |
| 06 | [Evaluation and traces](notebooks/06-evaluation-and-traces.ipynb) | OpenTelemetry to App Insights, built-in and custom evaluators, release gate (v1 pass, v2 blocked) |
| 07 | [Deploy a hosted agent](notebooks/07-deploy-hosted-agent.ipynb) | ACR build, hosted agent versions, gate-driven rollout, smoke test, rollback |

## Prerequisites

- Azure subscription with permission to create resources and role assignments (Owner, or Contributor + User Access Administrator) in a sandbox.
- `az` (logged in: `az login`), Bicep CLI, Python 3.12+, Git. No Docker needed (images build in ACR).
- Day 1 completed, or knowledge of the landing-zone and identity foundation the agent deploys onto.

## Setup

```bash
cd day-2
export USER_PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
bash scripts/deploy.sh --yes        # ~10 min: Foundry, models, Search, App Insights, ACR, roles; writes .env
python -m venv .venv && source .venv/bin/activate        # Windows: .venv/Scripts/activate
pip install --pre .                 # pinned dependencies from pyproject.toml (or install the pins directly)
```

See [docs/setup-notes.md](docs/setup-notes.md) for package notes (`uv sync` also works where TLS to PyPI is not intercepted). `.env` is git-ignored and holds endpoints only: auth is Entra (`DefaultAzureCredential`), no keys. Regenerate it any time with `bash scripts/write-env.sh`.

Run notebooks in order, one at a time: the model deployment is rate-limited and parallel runs return 429. Notebook 07 takes about 8 minutes for the ACR build. Notebook 03 keeps the shared Search index and knowledge base that 02, 06 and 07 use.

## Known limits

- Memory stores, Skills API, Foundry IQ knowledge base MCP and evaluators are preview; APIs may change. Notebooks say so where it applies.
- A weighted canary (90/10) is not available to callers; notebook 07 does a 100% switch with smoke test and rollback.
- The evaluation set is small (n=37, same-family LLM judge): treat scores as illustrative.

## Teardown

```bash
bash scripts/teardown.sh   # deletes rg-foundry-day2 and purges the soft-deleted Foundry account
```

Each notebook already deletes its own agents, versions and connections; teardown removes the rest (hosted agent versions, ACR images, Search, shared index).

## Take-home assets

[`templates/agent-blueprint.md`](templates/agent-blueprint.md), [`templates/deployment-readiness-checklist.md`](templates/deployment-readiness-checklist.md), [`sample-agent/`](sample-agent/) (pointer to the notebooks). Agenda: [docs/timelines.md](docs/timelines.md). Architecture: [docs/architecture.md](docs/architecture.md). Infra: [bicep/README.md](bicep/README.md).
