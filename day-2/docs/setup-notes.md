# Setup notes (Windows, private feed + TLS issue)

## Problem
`pip config` points to a private feed (`packagefeedproxy.microsoft.io`), and `uv` fails on
`files.pythonhosted.org` with `received fatal alert: HandshakeFailure` — even with
`--index-url https://pypi.org/simple` and `--native-tls`/`--system-certs`.

## Working command (verified)
`pip` from `C:/Python314` works (it uses the private feed, which mirrors PyPI). Use pip, not uv:

```bash
cd day-2
C:/Python314/python.exe -m venv .venv          # .venv is git-ignored
.venv/Scripts/python.exe -m pip install agent-framework azure-ai-projects azure-identity \
    azure-search-documents azure-monitor-opentelemetry mcp
```

Do not use `uv sync`/`uv pip` on this machine (HandshakeFailure). Always call
`.venv/Scripts/python.exe -m pip ...` (the global pip config has `require-virtualenv`).

## Versions that installed (2026-11-15)
agent-framework 1.26.0, agent-framework-core 1.26.0, agent-framework-foundry 1.16.2,
agent-framework-foundry-hosting 1.0.0b261112 (prerelease), agent-framework-azure-ai-search 1.0.0b261106 (prerelease),
agent-framework-openai 1.18.2, azure-ai-projects 2.11.0, azure-identity 1.27.0,
azure-search-documents 12.1.0, azure-monitor-opentelemetry 1.8.12, azure-ai-agentserver-core 2.3.0,
azure-ai-agentserver-responses 2.4.0, mcp 2.3.0, opentelemetry-sdk 1.45.2.

## Tooling present
az (logged in), Bicep CLI 0.49.2, azd 1.37.3. Docker is NOT installed (use ACR remote build / azd, or code-based deploy).
Git: `export PATH="/c/Program Files/Git/cmd:$PATH"`.
