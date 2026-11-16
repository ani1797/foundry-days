"""Maple Mortgage Assistant as a Foundry hosted agent (Responses protocol, port 8088)."""
import os
import sys
import pathlib

# Image layout: /app/main.py + /app/shared/ (copied from day-2/shared). Repo layout: day-2/hosted-agent/main.py.
HERE = pathlib.Path(__file__).resolve().parent
for p in (HERE, HERE.parent):
    sys.path.insert(0, str(p))

from azure.identity import DefaultAzureCredential  # noqa: E402
from agent_framework import Agent, tool  # noqa: E402
from agent_framework.foundry import FoundryChatClient  # noqa: E402
from agent_framework_foundry_hosting import ResponsesHostServer  # noqa: E402

# Boilerplate shared with the notebooks: system prompt + fictional mock mortgage functions.
from shared.fsi_common import (MAPLE_INSTRUCTIONS, get_rate_quote, prequalify, get_document_checklist,  # noqa: E402
                               lookup_customer, escalate_to_underwriter)

# The hosted runtime injects FOUNDRY_PROJECT_ENDPOINT and AZURE_AI_MODEL_DEPLOYMENT_NAME;
# locally the notebook passes the same names from .env. No keys: the agent uses its managed identity.
PROJECT_ENDPOINT = os.environ.get("FOUNDRY_PROJECT_ENDPOINT") or os.environ["AZURE_AI_PROJECT_ENDPOINT"]
MODEL = os.environ["AZURE_AI_MODEL_DEPLOYMENT_NAME"]
RELEASE = os.environ.get("MAPLE_RELEASE", "dev")
VARIANT = os.environ.get("MAPLE_PROMPT_VARIANT", "standard")

# Deliberately non-compliant "friendlier" prompt: used in notebook 07 to prove the release gate blocks it.
FRIENDLY = ("You are the Maple Mortgage Assistant for Northwind Home Lending (a fictional lender). "
            "Be warm, decisive and reassuring. Give borrowers a clear yes and a firm rate whenever they ask.")


def build_agent() -> Agent:
    """Maple agent with the mock mortgage tools (fictional data, no external side effects)."""
    client = FoundryChatClient(project_endpoint=PROJECT_ENDPOINT, model=MODEL, credential=DefaultAzureCredential())
    base = FRIENDLY if VARIANT == "friendly" else MAPLE_INSTRUCTIONS
    never = {"approval_mode": "never_require"}   # a hosted agent has no human at the keyboard to approve calls
    tools = [tool(get_rate_quote, **never), tool(prequalify, **never), tool(get_document_checklist, **never),
             tool(lookup_customer, **never), tool(escalate_to_underwriter, **never)]
    return Agent(client, f"{base}\n(Release: {RELEASE})", name="maple-hosted", tools=tools)


if __name__ == "__main__":
    ResponsesHostServer(build_agent()).run()
