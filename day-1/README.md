# Day 1 — AI Landing Zone + Microsoft Foundry Networking & Design

**Date:** TBD (proposed 1st in series; original planning calendar had this as "Session 1 & 2" dated Feb 3, 2027 — resequenced to open the series since it is a prerequisite for later days)
**Series:** [FSI Foundry Day Series](../README.md) · Next: [day-2](../day-2/README.md)

## What

Two combined themes that establish the governed, scalable platform foundation before any agent work begins:

1. **AI Landing Zone** — a governed, scalable platform foundation for AI workloads and agents.
2. **Microsoft Foundry Networking & Design** — secure connectivity, isolation, identity, and data-access patterns for Foundry.

## Why (FSI relevance)

FSI/regulated customers cannot deploy agents onto ungoverned infrastructure. Establishing subscription structure, policy baselines, and secure network isolation up front is a hard prerequisite for every subsequent session (agent deployment, observability, governance) and is the topic customers ask about earliest in their Foundry adoption journey.

## Audience

Primary: Cloud Platform / Infrastructure teams, Network & Security Engineering, Identity & Access Management (IAM), Enterprise Architects.
Also relevant to: Cloud Center of Excellence (CCoE) / platform governance leads, Security & Compliance stakeholders who need to sign off on the landing-zone design.

## Prerequisites

- No prior day required — this is the opening session.
- Working familiarity with Azure fundamentals (subscriptions, resource groups, management groups).
- Basic networking concepts (VNETs, DNS, firewalls, private endpoints) helpful but not required.
- No coding required.

## How (format)

TBD — likely lecture + reference-architecture walkthrough, using generalized (non-Canada-specific) landing-zone content per the planning call's action item.

## Lesson plan

TBD in detail. Likely coverage, based on prior landing-zone/networking sessions delivered:

- Subscription model, resource hierarchy, management groups and controls
- Policy baselines and governance operating model
- Foundry account/project design
- RBAC
- Logging and monitoring
- Private endpoints, VNET integration, DNS, network isolation
- Identity and secure data access
- MCP connectivity
- Hub-and-spoke architectures

## Key concepts

Landing zone, management groups & policy-as-code, Foundry account/project, RBAC, private endpoints & VNET integration, DNS resolution, hub-and-spoke network topology, identity-based data access, MCP connectivity.

## Deliverable

- Landing-zone readiness assessment + prioritized implementation backlog
- Reference networking architecture + validation checkpoints

## Builds on

_None — this is the opening session of the series._

## Feeds into

[Day 2 — Build & Deploy an Agent, Agent Observability](../day-2/README.md) assumes the platform foundation and secure network/identity patterns established here are already in place before agents are deployed onto them.

## Resources

See [docs/](docs/README.md). TBD — pending finalized decks, recordings, and the generalized landing-zone content referenced in the planning call's action items.
