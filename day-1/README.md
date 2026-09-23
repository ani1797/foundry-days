# Day 1 — AI Landing Zone + Microsoft Foundry Networking & Design

**Date:** October 15, 2026, 10:00 AM – 2:00 PM
**Series:** [FSI Foundry Day Series](../README.md) · Next: [day-2](../day-2/README.md)

## What

Two combined themes that establish the governed, scalable platform foundation before any agent work begins:

1. **AI Landing Zone** — a governed, scalable platform foundation for AI workloads and agents.
2. **Microsoft Foundry Networking & Design** — secure connectivity, isolation, identity, and data-access patterns for Foundry.

## Why

FSI/regulated customers cannot deploy agents onto ungoverned infrastructure. Establishing subscription structure, policy baselines, and secure network isolation up front is a hard prerequisite for every subsequent session (agent deployment, observability, governance) and is the topic customers ask about earliest in their Foundry adoption journey.

**Key concepts:** Landing zone, management groups & policy-as-code, Foundry account/project, RBAC, private endpoints & VNET integration, DNS resolution, hub-and-spoke network topology, identity-based data access, MCP connectivity.

## Audience

Primary: Cloud Platform / Infrastructure teams, Network & Security Engineering, Identity & Access Management (IAM), Enterprise Architects.
Also relevant to: Cloud Center of Excellence (CCoE) / platform governance leads, Security & Compliance stakeholders who need to sign off on the landing-zone design.

## Prerequisites

- No prior day required — this is the opening session.
- Working familiarity with Azure fundamentals (subscriptions, resource groups, management groups).
- Basic networking concepts (VNETs, DNS, firewalls, private endpoints) helpful but not required.
- No coding required.

## Format

Classroom-style lecture + reference-architecture walkthrough. Room supports laptops and hands-on exploration, ~40 seats with overflow, Teams bridge for remote attendees, registration/waitlist enabled (registrants may be auto-enrolled into future sessions). Content uses generalized (non-Canada-specific) landing-zone material.

## Lesson plan

Full block-by-block agenda: [docs/timelines.md](docs/timelines.md).

- Foundry architecture overview
- AI Landing Zone design (management groups, subscriptions, policy, tagging, core platform capabilities)
- Network topology, private connectivity, DNS, routing, firewalls, proxy patterns, outbound connectivity
- Identity and data protection (managed identities, Foundry RBAC, secrets, encryption)
- Operating model and guardrails (platform ownership, approved patterns, exception handling)
- MCP/agent/external connectivity considerations

**Explicitly deferred:** deep security architecture, Agent 365 security model, On-Behalf-Of (OBO) flows, Foundry control-plane security deep dive, detailed observability — candidates for a future dedicated security session (TBD, not yet on the roadmap).

## Deliverable

- **Artifact:** Landing-zone readiness assessment + prioritized implementation backlog; reference networking architecture + validation checklist.
- **Take-home assets:** [`templates/landing-zone-readiness-assessment.md`](templates/landing-zone-readiness-assessment.md), [`templates/reference-architecture.md`](templates/reference-architecture.md), [`templates/validation-checklist.md`](templates/validation-checklist.md), [`bicep/`](bicep/) (basic, network-isolated, and hub-spoke Foundry setups).

## Recap

_None — this is the opening session of the series._

## Resources

See [docs/](docs/) and [docs/timelines.md](docs/timelines.md) for materials, and [templates/](templates/) and [bicep/](bicep/) for take-home templates and Bicep deployments. TBD — pending finalized decks, recordings, and the generalized landing-zone content.
