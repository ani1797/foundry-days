# Day 2 notebook outlines and shared helper contract

Case study: **Maple Mortgage Assistant**, Northwind Home Lending (fictional). Each notebook: title, "What you'll learn", Setup cell (`from shared.fsi_common import ...`), demo cells with a visible result, Key Takeaways, "Next up". Cells marked **[preview]** need an "Optional / unavailable in your region" note and must not fake output. API claims: *installed* = imported/introspected/constructed in `.venv` (recon report); *doc* = Learn docs only. **Nothing is live-verified yet**; each notebook must be executed live before "done".

Common conventions: `AZURE_AI_*` env names (spec) are mapped to AF's `project_endpoint=` / `model=` arguments by `fsi_common` (AF's own env names are `FOUNDRY_*`, so never rely on implicit env). Async cells use top-level `await` (Jupyter). Learner chooses a per-run unique suffix only where names collide.

## `shared/fsi_common.py` contract (architect defines, software-engineer writes)

```python
# Config / auth
@dataclass(frozen=True)
class Settings:           # fields mirror .env.example, all str; optional ones may be ""
    subscription_id; resource_group; location
    project_endpoint; model; embedding_model
    search_endpoint; search_index; search_kb; kb_connection_name
    appinsights_connection_string; acr_name
def load_settings(env_file: str | None = None, require: Sequence[str] = ()) -> Settings
    # loads day-2/.env (python-dotenv, override=False); raises SettingsError listing missing names in `require`; never prints values
def get_credential() -> azure.identity.DefaultAzureCredential

# Clients
def get_project_client(settings: Settings | None = None, *, allow_preview: bool = False) -> AIProjectClient
def get_chat_client(settings: Settings | None = None) -> agent_framework.foundry.FoundryChatClient
def make_agent(name: str, instructions: str, *, tools: Sequence = (), context_providers: Sequence = (),
               settings: Settings | None = None) -> agent_framework.Agent   # uses get_chat_client
def get_foundry_agent(agent_name: str, agent_version: str | None = None, settings=None) -> agent_framework.foundry.FoundryAgent

# Case-study content
MAPLE_INSTRUCTIONS: str      # shared system prompt: no rate promises, always add disclosure, mask PII, escalate to underwriter when unsure
DISCLOSURE: str              # standard "indicative only, not a commitment to lend" text
def data_path(*parts: str) -> pathlib.Path      # day-2/data/<parts>
def skills_path() -> pathlib.Path               # day-2/skills

# Mock mortgage tools (plain functions + `@tool(approval_mode="never_require")` wrappers; deterministic, read data/rates.json & customers.json; fictional only)
def get_rate_quote(term_years: int, credit_band: str, ltv_pct: float) -> dict   # {rate_pct, apr_pct, as_of, disclosure}; "indicative"
def prequalify(annual_income: float, monthly_debts: float, down_payment: float, price: float) -> dict  # {gds_pct, tds_pct, ltv_pct, decision: "likely"|"refer"|"unlikely", reasons: list[str]}
def get_document_checklist(employment_type: str) -> list[str]
def lookup_customer(customer_id: str) -> dict     # masked PII (last-4 style), from customers.json
def escalate_to_underwriter(case_id: str, reason: str) -> dict   # {ticket_id, status:"queued"} audit-log entry, no side effects
TOOLS: list   # the @tool-decorated versions of the five above, in that order

# Output hygiene
def redact(text: str) -> str          # masks emails, phone numbers, SIN/SSN-like and 16-digit card patterns
def show(response, *, title: str | None = None) -> None   # pretty-prints response.text (redacted) and usage if present
def print_env_check(settings: Settings) -> None           # prints set/unset per variable, never values

# Observability
def setup_tracing(settings: Settings | None = None, *, sensitive: bool = False) -> None
    # configure_azure_monitor(connection_string=...) + agent_framework.observability.enable_instrumentation(enable_sensitive_data=sensitive); idempotent
```
Constraints: no module-level network calls; imports work with only core deps; every function has a docstring and type hints; `TOOLS` argument names/types stable (notebooks and hosted agent import them); unit tests under `shared/tests/` for the mock tools and `redact`.

## 01-build-an-agent.ipynb (software-engineer)
- **Objectives:** run a model-backed AF agent; create a server-side prompt agent in Foundry Agent Service and call it; understand hosted agents conceptually (code vs prompt).
- **FSI beat:** loan officer asks the assistant for a first-time-buyer pre-qual explanation; the compliance system prompt refuses to promise a rate.
- **Cells:** (1) setup + `print_env_check`; (2) `make_agent("maple", MAPLE_INSTRUCTIONS)` run + stream; (3) refusal test: "Promise me 4.1%"; (4) `AgentSession` multi-turn; (5) create prompt agent `maple-prompt` via `pc.agents.create_version(PromptAgentDefinition)`; list versions in portal-visible form; (6) call it through `FoundryAgent`; (7) table: code agent vs prompt agent vs hosted agent; (8) takeaways.
- **APIs:** `Agent`, `FoundryChatClient(project_endpoint, model, credential)`, `agent.run(stream=True)`, `create_session`, `pc.agents.create_version(agent_name, definition=PromptAgentDefinition(model, instructions))`, `FoundryAgent(project_endpoint, agent_name, agent_version, credential)` (all *installed*/signature-verified; calls *doc*).
- **Depends on:** infra (project, chat deployment); shared: `make_agent`, `get_project_client`, `MAPLE_INSTRUCTIONS`, `show`.

## 02-tools-and-mcp.ipynb (software-engineer)
- **Objectives:** function tools with approval modes; MCP tool (remote Learn MCP and a local MCP server); Foundry-side MCP tool for prompt agents; Toolbox concept.
- **FSI beat:** agent quotes an indicative rate and pre-qualifies a borrower using tools, then escalates a self-employed edge case; compliance sees an approval gate on `escalate_to_underwriter`.
- **Cells:** (1) setup; (2) `Agent(tools=TOOLS)` ask a rate/pre-qual question, show tool calls; (3) `approval_mode="always_require"` demo on escalation with approve/deny loop; (4) `MCPStreamableHTTPTool("learn", "https://learn.microsoft.com/api/mcp")` regulatory-doc-style question; (5) local MCP server (`mcp` package, stdio, wraps `get_document_checklist`) via `MCPStdioTool`, in `mcp_servers/` or inline script file; (6) server-side `MCPTool` in a `PromptAgentDefinition` **[preview-ish]**; (7) **[preview]** `FoundryToolbox` note/demo only if a toolbox exists, otherwise markdown only; (8) takeaways.
- **APIs:** `@tool`, `MCPStreamableHTTPTool`, `MCPStdioTool`, `client.get_mcp_tool`, `MCPTool` (*installed*); `FoundryToolbox` (*installed*, not constructed live).
- **Depends on:** infra; shared: `TOOLS`, mock tools, `make_agent`; data: `rates.json`, `customers.json`.

## 03-foundry-iq-knowledge.ipynb (integrations-engineer)
- **Objectives:** chunk and index policy docs in Azure AI Search; create a knowledge source + knowledge base; ground an agent with Foundry IQ (KB MCP) and with the AF context provider; cite sources, say "I don't know".
- **FSI beat:** underwriting-policy Q&A (income documentation, gift funds, LTV caps) with citations; a question outside the corpus triggers "I don't know, escalating".
- **Cells:** (1) setup; (2) create index (vector + semantic config) with `azure-search-documents`, embed `data/policies/*.md` using the embedding deployment; (3) classic retrieval query to show baseline; (4) create knowledge source + KB (REST `2026-08-01-preview` or preview SDK classes **[preview; class names unverified, check first]**); (5) MCP endpoint + project connection check; (6) prompt agent with `MCPTool(allowed_tools=["knowledge_base_retrieve"], project_connection_id=...)`; ask grounded and out-of-scope questions; (7) AF alternative: `AzureAISearchContextProvider(mode="agentic")` **[preview pkg]**; (8) takeaways: when RAG vs agentic retrieval.
- **APIs:** `SearchIndexClient`/`SearchClient` (*installed*), KB REST (*doc*), `MCPTool`, `AzureAISearchContextProvider` (*installed*, signature only).
- **Depends on:** infra (Search, KB connection, RBAC); data: `policies/*.md`; shared: clients, `MAPLE_INSTRUCTIONS`.

## 04-memory.ipynb (integrations-engineer)
- **Objectives:** short-term state with `AgentSession`; long-term Foundry memory store with per-customer scope; memory hygiene and compliance (scope isolation, deletion).
- **FSI beat:** returning borrower (fictional "Priya") resumes a pre-qual conversation weeks later; a second customer sees none of her facts; a right-to-erasure call deletes her scope.
- **Cells:** (1) setup; (2) session persistence: serialize/restore `AgentSession`; (3) **[preview]** `pc.beta.memory_stores.create(MemoryStoreDefaultDefinition(chat_model, embedding_model, options))`; (4) agent with `FoundryMemoryProvider(memory_store_name, scope=customer_id, update_delay=0)`; two sessions, recall demo; (5) isolation demo with another scope; (6) `search_memories` and `delete_scope`; (7) takeaways incl. PII-in-memory policy.
- **APIs:** `AgentSession`, `FoundryMemoryProvider`, `pc.beta.memory_stores.*` with `allow_preview=True` (*installed*, calls *doc*).
- **Depends on:** infra (chat + embedding deployments, Foundry User for project MI); data: `customers.json`; shared: `get_project_client(allow_preview=True)`.

## 05-skills-and-registry.ipynb (integrations-engineer)
- **Objectives:** author an Agent Skill (SKILL.md, resources, scripts); load via `SkillsProvider`; progressive disclosure; a registry (index + versioning), optionally Foundry Skills API.
- **FSI beat:** skills `doc-checklist`, `adverse-action-notice`, `rate-disclosure`; the agent loads only the one needed; registry pins versions so compliance approves a skill version.
- **Cells:** (1) setup; (2) inspect `skills/*/SKILL.md`; (3) `SkillsProvider(FileSkillsSource(skills_path()))` agent, show `load_skill` calls; (4) skill resource and script run with approval **[script runner needed]**; (5) registry: read `skills/index.json` (name, version, owner, approved, sha256), `FilteringSkillsSource` to only approved, verify hashes; (6) **[preview]** upload/list versions via `pc.beta.skills`; (7) takeaways.
- **APIs:** `SkillsProvider`, `FileSkillsSource`, `FilteringSkillsSource`, `AggregatingSkillsSource`, `MCPSkillsSource`, `pc.beta.skills.*` (*installed*; core constructed offline).
- **Depends on:** `skills/` folder; shared: `make_agent`, `skills_path`.

## 06-evaluation-and-traces.ipynb (data-scientist)
- **Objectives:** send agent traces to App Insights; read them back; evaluate with built-in Foundry evaluators on a dataset; set a quality gate.
- **FSI beat:** compliance review sample: groundedness against policy, task adherence (no rate promises), safety; gate blocks a regressed prompt version.
- **Cells:** (1) setup + `setup_tracing()`; (2) run agent on 5 queries, show trace/span view or KQL (azure-monitor-query or portal link); (3) load `data/eval/*.jsonl`; (4) `FoundryEvals(client, evaluators=["relevance","groundedness","task_adherence"])` over dataset or `evaluate_foundry_target` **[experimental]**; (5) `evaluate_traces` on recent responses **[experimental]**; (6) results table and threshold gate (assert); (7) takeaways incl. sensitive-data flag off.
- **APIs:** `configure_azure_monitor`, `enable_instrumentation`, `FoundryEvals`, `evaluate_traces`, `evaluate_foundry_target` (*installed*, signatures only), `pc.telemetry.get_application_insights_connection_string()` (*installed*, verified exists), `pc.get_openai_client().evals` (*doc*).
- **Depends on:** infra (App Insights, judge deployment); data: eval dataset; shared: `setup_tracing`, `make_agent`, `get_chat_client`. Note: add `azure-monitor-query` to pyproject if KQL readback is used (not yet pinned).

## 07-deploy-hosted-agent.ipynb (software-engineer)
- **Objectives:** package the agent as a hosted agent; build without local Docker; deploy a version; invoke; roll back; release gate using nb06 evals.
- **FSI beat:** promote Maple v2 only if eval gate passes; rollback to v1 retained for audit.
- **Cells:** (1) setup; (2) walk `hosted-agent/main.py` (`ResponsesHostServer(agent).run()`); (3) local run + `POST /responses` smoke (subprocess, port 8088); (4) build: `az acr build` (primary, subprocess) or `create_version_from_code` zip; (5) `create_version(HostedAgentDefinition(...))`, poll until active; (6) invoke via `FoundryAgent`/`get_openai_client(agent_name=)`; (7) deploy v2, run gate, rollback story; (8) cost/teardown note: delete the hosted agent version; takeaways.
- **APIs:** `ResponsesHostServer`, `HostedAgentDefinition`, `ProtocolVersionRecord`, `AgentEndpointProtocol`, `ContainerConfiguration`, `create_version`, `create_version_from_code` (*installed*; deploy calls *doc*, unverified live).
- **Depends on:** infra (ACR, RBAC: Container Registry Repository Reader), `hosted-agent/`, shared package copied into the image, nb06 eval helper.

## Open questions for build
1. KB/knowledge-source creation: SDK classes vs REST (nb03 owner checks first).
2. `azure-monitor-query` needed? (nb06 owner decides, then adds the pin to `pyproject.toml` via architect/lead).
3. Hosted agent: code-deploy vs ACR image (software-engineer picks after trying `create_version_from_code`).
