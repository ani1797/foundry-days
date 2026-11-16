"""Shared helpers for the Day 2 Maple Mortgage Assistant notebooks (Northwind Home Lending, fictional)."""
from __future__ import annotations

import os
import pathlib
import re
import zlib
from dataclasses import dataclass, fields
from typing import Any, Sequence

DAY2_ROOT = pathlib.Path(__file__).resolve().parents[1]


class SettingsError(RuntimeError):
    """Raised when required environment variables are missing."""


_ENV_MAP = {
    "subscription_id": "AZURE_SUBSCRIPTION_ID", "resource_group": "AZURE_RESOURCE_GROUP",
    "location": "AZURE_LOCATION", "project_endpoint": "AZURE_AI_PROJECT_ENDPOINT",
    "model": "AZURE_AI_MODEL_DEPLOYMENT_NAME", "embedding_model": "AZURE_AI_EMBEDDING_DEPLOYMENT_NAME",
    "search_endpoint": "AZURE_SEARCH_ENDPOINT", "search_index": "AZURE_SEARCH_INDEX_NAME",
    "search_kb": "AZURE_SEARCH_KNOWLEDGE_BASE_NAME", "kb_connection_name": "AZURE_AI_KB_CONNECTION_NAME",
    "appinsights_connection_string": "APPLICATIONINSIGHTS_CONNECTION_STRING",
    "acr_name": "AZURE_CONTAINER_REGISTRY_NAME",
}


@dataclass(frozen=True)
class Settings:
    """Typed view of day-2/.env. Optional values may be empty strings."""
    subscription_id: str = ""
    resource_group: str = ""
    location: str = ""
    project_endpoint: str = ""
    model: str = ""
    embedding_model: str = ""
    search_endpoint: str = ""
    search_index: str = ""
    search_kb: str = ""
    kb_connection_name: str = ""
    appinsights_connection_string: str = ""
    acr_name: str = ""


def load_settings(env_file: str | None = None, require: Sequence[str] = ()) -> Settings:
    """Load settings from day-2/.env (override=False). `require` lists Settings field names that must be set."""
    from dotenv import load_dotenv
    load_dotenv(env_file or DAY2_ROOT / ".env", override=False)
    s = Settings(**{k: os.environ.get(v, "") for k, v in _ENV_MAP.items()})
    missing = [_ENV_MAP[r] for r in require if not getattr(s, r)]
    if missing:
        raise SettingsError("Missing environment variables: " + ", ".join(missing))
    return s


def get_credential():
    """Return a DefaultAzureCredential (Entra ID only, no keys)."""
    from azure.identity import DefaultAzureCredential
    return DefaultAzureCredential()


def get_project_client(settings: Settings | None = None, *, allow_preview: bool = False):
    """Create an AIProjectClient for the Foundry project."""
    from azure.ai.projects import AIProjectClient
    s = settings or load_settings(require=("project_endpoint",))
    kw: dict[str, Any] = {"allow_preview": True} if allow_preview else {}
    return AIProjectClient(endpoint=s.project_endpoint, credential=get_credential(), **kw)


def get_chat_client(settings: Settings | None = None):
    """Create a FoundryChatClient bound to the project and chat deployment."""
    from agent_framework.foundry import FoundryChatClient
    s = settings or load_settings(require=("project_endpoint", "model"))
    return FoundryChatClient(project_endpoint=s.project_endpoint, model=s.model, credential=get_credential())


def make_agent(name: str, instructions: str, *, tools: Sequence = (), context_providers: Sequence = (),
               settings: Settings | None = None):
    """Build an Agent Framework Agent on the Foundry chat client."""
    from agent_framework import Agent
    return Agent(get_chat_client(settings), instructions, name=name, tools=list(tools) or None,
                 context_providers=list(context_providers) or None)


def get_foundry_agent(agent_name: str, agent_version: str | None = None, settings: Settings | None = None):
    """Wrap a server-side Foundry agent (prompt or hosted) as an Agent Framework FoundryAgent."""
    from agent_framework.foundry import FoundryAgent
    s = settings or load_settings(require=("project_endpoint",))
    return FoundryAgent(project_endpoint=s.project_endpoint, agent_name=agent_name,
                        agent_version=agent_version, credential=get_credential())


# ---------------------------------------------------------------- case-study content
DISCLOSURE = ("Indicative only. Not a commitment to lend. Rates and eligibility are subject to full "
              "application, credit adjudication and underwriter approval.")

MAPLE_INSTRUCTIONS = f"""You are the Maple Mortgage Assistant for Northwind Home Lending (a fictional lender).
You help loan officers and borrowers with mortgage pre-qualification, indicative rate quotes,
document checklists and policy questions.
Rules:
- Never promise, guarantee or lock a rate or approval. Quotes are indicative only.
- End every message that mentions a rate or eligibility with this disclosure: "{DISCLOSURE}"
- Mask personal data (SIN/SSN, card numbers, full emails/phones); never repeat them back.
- When unsure, or for edge cases (self-employed income, large gifts, credit issues), escalate to a human underwriter.
- Be concise and plain-spoken."""


def data_path(*parts: str) -> pathlib.Path:
    """Path under day-2/data/."""
    return DAY2_ROOT.joinpath("data", *parts)


def skills_path() -> pathlib.Path:
    """Path of day-2/skills."""
    return DAY2_ROOT / "skills"


# ---------------------------------------------------------------- mock mortgage tools (fictional, deterministic)
# Embedded so the helper works before/without data/*.json (the data worker owns those files).
_BASE_RATES = {1: 5.29, 2: 5.09, 3: 4.89, 5: 4.79, 7: 5.19, 10: 5.39}  # term years -> % (fictional)
_CREDIT_ADJ = {"excellent": -0.10, "good": 0.00, "fair": 0.35, "poor": 0.90}
_AS_OF = "2026-11-01"
_CUSTOMERS = {
    "C-1001": {"name": "Priya Nair", "email": "priya.nair@example.com", "phone": "416-555-0142",
               "sin": "123-456-789", "employment": "salaried", "credit_band": "good"},
    "C-1002": {"name": "Marcus Chen", "email": "marcus.chen@example.com", "phone": "604-555-0177",
               "sin": "987-654-321", "employment": "self-employed", "credit_band": "fair"},
}
_CHECKLISTS = {
    "salaried": ["Government photo ID", "Two most recent pay stubs", "Employment letter (within 30 days)",
                 "Last two years' T4s / Notices of Assessment", "90 days of down-payment bank statements"],
    "self-employed": ["Government photo ID", "Two years' Notices of Assessment and T1 Generals",
                      "Business registration or articles of incorporation",
                      "Two years' financial statements", "90 days of business and personal bank statements",
                      "Down-payment source confirmation"],
    "retired": ["Government photo ID", "Pension and CPP/OAS statements", "Last two years' Notices of Assessment",
                "90 days of bank statements"],
}


def get_rate_quote(term_years: int, credit_band: str, ltv_pct: float) -> dict:
    """Indicative fixed-rate quote from a fictional rate sheet. Not a commitment."""
    base = _BASE_RATES.get(term_years)
    if base is None:
        return {"error": f"Unsupported term {term_years}; choose from {sorted(_BASE_RATES)}", "disclosure": DISCLOSURE}
    adj = _CREDIT_ADJ.get(credit_band.lower(), 0.35)
    ltv_adj = 0.15 if ltv_pct > 80 else 0.0
    rate = round(base + adj + ltv_adj, 2)
    return {"rate_pct": rate, "apr_pct": round(rate + 0.07, 2), "term_years": term_years,
            "as_of": _AS_OF, "indicative": True, "disclosure": DISCLOSURE}


def prequalify(annual_income: float, monthly_debts: float, down_payment: float, price: float) -> dict:
    """Simple GDS/TDS/LTV pre-qualification screen (fictional limits: GDS 39%, TDS 44%, LTV 95%)."""
    if annual_income <= 0 or price <= 0:
        return {"decision": "unlikely", "reasons": ["Income and price must be positive"], "disclosure": DISCLOSURE}
    loan = max(price - down_payment, 0.0)
    ltv = loan / price * 100
    monthly_income = annual_income / 12
    housing = loan * 0.0062 + price * 0.0012  # payment factor (~5.5% stress rate) + tax/heat placeholder
    gds = housing / monthly_income * 100
    tds = (housing + monthly_debts) / monthly_income * 100
    reasons = []
    if ltv > 95:
        reasons.append("LTV above 95% maximum")
    if gds > 39:
        reasons.append(f"GDS {gds:.1f}% above 39% limit")
    if tds > 44:
        reasons.append(f"TDS {tds:.1f}% above 44% limit")
    if not reasons:
        decision = "likely" if (gds <= 35 and tds <= 40 and ltv <= 80) else "refer"
        reasons.append("Within guideline limits" if decision == "likely"
                       else "Within limits but close: refer to underwriter")
    else:
        decision = "unlikely" if len(reasons) > 1 else "refer"
    return {"gds_pct": round(gds, 1), "tds_pct": round(tds, 1), "ltv_pct": round(ltv, 1),
            "decision": decision, "reasons": reasons, "disclosure": DISCLOSURE}


def get_document_checklist(employment_type: str) -> list[str]:
    """Documents needed for a mortgage application by employment type (salaried, self-employed, retired)."""
    return list(_CHECKLISTS.get(employment_type.lower().strip(), _CHECKLISTS["salaried"]))


def lookup_customer(customer_id: str) -> dict:
    """Fictional customer profile with PII masked."""
    c = _CUSTOMERS.get(customer_id)
    if not c:
        return {"error": f"Unknown customer {customer_id}"}
    first, last = c["name"].split()
    return {"customer_id": customer_id, "name": f"{first} {last[0]}.",
            "email": c["email"][0] + "***@" + c["email"].split("@")[1], "phone": "***-***-" + c["phone"][-4:],
            "sin": "***-***-" + c["sin"][-3:], "employment": c["employment"], "credit_band": c["credit_band"]}


_AUDIT_LOG: list[dict] = []


def escalate_to_underwriter(case_id: str, reason: str) -> dict:
    """Queue a case for a human underwriter (in-memory audit entry; no external side effects)."""
    ticket = f"UW-{zlib.crc32(case_id.encode()) % 100000:05d}"
    _AUDIT_LOG.append({"ticket_id": ticket, "case_id": case_id, "reason": reason})
    return {"ticket_id": ticket, "status": "queued", "case_id": case_id}


def audit_log() -> list[dict]:
    """Return the in-memory escalation audit log."""
    return list(_AUDIT_LOG)


def _build_tools(escalation_mode: str = "never_require") -> list:
    from agent_framework import tool
    never = {"approval_mode": "never_require"}
    return [tool(get_rate_quote, **never), tool(prequalify, **never), tool(get_document_checklist, **never),
            tool(lookup_customer, **never),
            tool(escalate_to_underwriter, approval_mode=escalation_mode)]


def __getattr__(name: str):
    """Lazy `TOOLS` so the module imports with core deps only."""
    if name == "TOOLS":
        return _build_tools()
    raise AttributeError(name)


# ---------------------------------------------------------------- output hygiene
_PATTERNS = [
    (re.compile(r"\b[\w.+-]+@[\w-]+\.[\w.-]+\b"), "[email]"),
    (re.compile(r"\b(?:\d[ -]?){15}\d\b"), "[card]"),
    (re.compile(r"\b\d{3}[- ]\d{3}[- ]\d{3}\b"), "[sin]"),
    (re.compile(r"\b\d{3}-\d{2}-\d{4}\b"), "[ssn]"),
    (re.compile(r"(?<!\d)(?:\+?1[ -.]?)?\(?\d{3}\)?[ -.]\d{3}[ -.]\d{4}\b"), "[phone]"),
]


def redact(text: str) -> str:
    """Mask emails, phone numbers, SIN/SSN-like and 16-digit card patterns."""
    for pat, repl in _PATTERNS:
        text = pat.sub(repl, text)
    return text


def show(response: Any, *, title: str | None = None) -> None:
    """Pretty-print an agent response's text (redacted) and usage if present."""
    if title:
        print(f"=== {title} ===")
    print(redact(getattr(response, "text", str(response))))
    usage = getattr(response, "usage_details", None)
    if usage:
        print(f"[usage] {dict(usage)}")


def print_env_check(settings: Settings) -> None:
    """Print set/unset per variable, never values."""
    for f in fields(settings):
        print(f"{_ENV_MAP[f.name]:42s} {'set' if getattr(settings, f.name) else 'UNSET'}")


_TRACING_ON = False


def setup_tracing(settings: Settings | None = None, *, sensitive: bool = False) -> None:
    """Send Agent Framework traces to Application Insights (idempotent)."""
    global _TRACING_ON
    if _TRACING_ON:
        return
    from azure.monitor.opentelemetry import configure_azure_monitor
    from agent_framework.observability import enable_instrumentation
    s = settings or load_settings(require=("appinsights_connection_string",))
    configure_azure_monitor(connection_string=s.appinsights_connection_string)
    enable_instrumentation(enable_sensitive_data=sensitive)
    _TRACING_ON = True
