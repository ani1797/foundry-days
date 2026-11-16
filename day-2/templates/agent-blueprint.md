# Agent Blueprint

Fill in during the guided design activity (worked example: Maple Mortgage Assistant).

## Use case
- Business problem:
- Target user (e.g. loan officer / borrower):
- Success looks like (measurable, e.g. 95% of policy answers carry a citation):

## Architecture (notebook)
- Instructions and compliance rules (01): e.g. no rate promises, required disclosures
- Model (01):
- Knowledge (03): sources, index, grounding, "I don't know" behavior
- Tools and MCP (02): function tools, approval-gated actions (escalation), MCP servers
- Memory (04): what is remembered, scope, retention, erasure path
- Skills (05): approved skills, owner, version pinning
- Identity and access: managed identity, roles (least privilege), Entra-only auth
- Environment: dev / test / prod, region, resource group, tags

## Task flows tested
| Task flow | Expected outcome | Evaluator / dataset row | Tested? |
|-----------|------------------|-------------------------|---------|
| | | | |

## Compliance and risk
- PII handling:
- Audit trail (traces, approvals):
- Human escalation trigger:

## Known limitations / out of scope
-
