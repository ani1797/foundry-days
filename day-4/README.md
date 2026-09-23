# Day 4 — Agent Governance and Security

**Date:** TBD (proposed 4th in series, targeting January)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-3](../day-3/README.md) · Next: [day-5](../day-5/README.md)

## What

Enterprise controls for trustworthy agent adoption, from design through production operations: governance operating model, security design, and trust/assurance. High-level identity concepts only — deep security topics (Agent 365, OBO, Foundry control-plane security) are explicitly deferred to a possible future dedicated security session.

## Why

This is a **major focus area** for the whole series since it targets regulated industries directly. FSI customers need an explicit, auditable control map before they will approve production agent programs.

**Key concepts:** Risk classification, use-case intake, approval models, least privilege, identity, secrets management, environment isolation, evaluation gates, human oversight, audit evidence, policy enforcement, model risk management.

## Audience

Primary: Security & Risk / CISO teams, Compliance & Governance, Identity & Access Management (IAM).
Also relevant to: Enterprise Architects, Internal Audit, Responsible AI / Model Risk Management stakeholders who must approve production agent programs.

## Prerequisites

- Completion of [Day 1](../day-1/README.md) (identity/RBAC foundation) and [Day 3](../day-3/README.md) (evaluation signals feeding into controls).
- Familiarity with enterprise security/compliance frameworks (e.g., internal risk/audit processes) helpful.
- General Responsible AI awareness helpful but not required.

## Format

Lecture + control-map workshop, 2 hours, supported by the `Azure AI Foundry Governance.PPTX` deck.

## Lesson plan

Full block-by-block agenda: [docs/timelines.md](docs/timelines.md).

- Risk framing: risks of agent autonomy, tool usage, data access
- Governance operating model: roles/responsibilities, use-case intake, risk classification, approval models, lifecycle management
- Security design: least privilege, identity, data protection, network boundaries, secrets management, environment isolation
- Trust and assurance: evaluation gates, human oversight, audit evidence, policy enforcement, change management
- Control mapping activity: map risks to controls, identify owners, define evidence requirements

**Explicitly deferred:** deep security architecture (Agent 365, OBO, Foundry control-plane) — candidate for a future dedicated security session (TBD, not yet on the roadmap).

## Deliverable

- **Artifact:** Governance and security control map.
- **Take-home assets:** [`templates/governance-control-map.md`](templates/governance-control-map.md), [`templates/governance-package-checklist.md`](templates/governance-package-checklist.md).

## Recap

[Day 3](../day-3/README.md) delivered evaluation and observability signals, on top of the identity/RBAC foundation from [Day 1](../day-1/README.md). This session turns those signals into governance and security controls.

## Resources

See [docs/](docs/) and [docs/timelines.md](docs/timelines.md) for materials, and [templates/](templates/) for take-home templates. Related: `Azure AI Foundry Governance.PPTX` (internal deck) — TBD to link once finalized for this session.
