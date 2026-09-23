# Day 2 — Build and Deploy an Agent

**Date:** TBD (proposed 2nd in series, targeting November)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-1](../day-1/README.md) · Next: [day-3](../day-3/README.md)

## What

From use case to a deployable agent: designing an agent on Microsoft Foundry, connecting knowledge and tools, evaluating its behavior, and planning deployment. Deep observability and evaluation content is deferred to Day 3.

## Why

Regulated customers need a repeatable, auditable path from prototype to deployment-ready agent — not ad-hoc builds. This session gives developers a consistent agent design pattern that Day 3 (evaluation/observability) and Day 4 (governance) build on.

**Key concepts:** Agent instructions, models, knowledge grounding, tools/actions, agent identity, environment decisions, deployment readiness, release gates.

## Audience

Primary: AI/ML Engineers, Application Developers, Platform Engineering / DevOps.
Also relevant to: Enterprise Architects tracking deployment patterns, SRE/Ops teams who will operate the agent in production.

## Prerequisites

- Completion of [Day 1](../day-1/README.md), or working knowledge of the landing-zone/network/identity foundation the agent will be deployed onto.
- General programming experience (Python or C#) and familiarity with REST APIs.
- Basic familiarity with the Azure AI Foundry portal/SDK helpful but not required.

## Format

Lecture + live build/deploy walkthrough, 2 hours. Scope is intentionally straightforward — a repeatable build-and-deploy path, not a deep dive.

## Lesson plan

Full block-by-block agenda: [docs/timelines.md](docs/timelines.md).

- Use case framing (proposed FSI case study: mortgage or insurance agent, stretch goal)
- Agent architecture essentials: instructions, models, knowledge grounding, tools, actions, identity, environment
- Live build demonstration: create an agent, connect knowledge sources and tools, test task flows
- Evaluation and deployment readiness: success criteria, test cases, failure handling, versioning, release gates
- Guided design activity: build an agent blueprint + deployment readiness checklist

## Deliverable

- **Artifact:** Agent blueprint + deployment readiness checklist.
- **Take-home assets:** [`templates/agent-blueprint.md`](templates/agent-blueprint.md), [`templates/deployment-readiness-checklist.md`](templates/deployment-readiness-checklist.md), [`sample-agent/`](sample-agent/) (starter code).

## Recap

[Day 1](../day-1/README.md) delivered the governed landing-zone platform foundation and secure network/identity patterns. The agent in this session is designed and deployed onto that foundation.

## Resources

See [docs/](docs/) and [docs/timelines.md](docs/timelines.md) for materials, and [templates/](templates/) and [sample-agent/](sample-agent/) for take-home templates and the sample agent. TBD — pending finalized decks, recordings, and demo materials.
