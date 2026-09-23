# Day 3 — Evaluations and FinOps

**Date:** TBD (proposed 3rd in series; original planning calendar listed this as "Session 4," dated Wednesday, November 4, 2026)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-2](../day-2/README.md) · Next: [day-4](../day-4/README.md)

## What

Measuring agent quality, reliability, cost, and operational health. Kept as a dedicated session, deliberately separate from Day 2's observability content, because governance and guardrails (Day 4) depend specifically on evaluation results.

## Why (FSI relevance)

Regulated customers require demonstrable quality gates and cost accountability before agents can be trusted in production. This session gives platform/ops teams the operational cadence needed to sustain that trust over time.

## Audience

Primary: Data Scientists / ML Engineers, FinOps & Cloud Cost Management, Platform Operations teams.
Also relevant to: Enterprise Architects, Governance/Risk stakeholders who consume evaluation signals as inputs to Day 4 controls.

## Prerequisites

- Completion of [Day 2](../day-2/README.md): a deployed, observable/instrumented agent is the subject being evaluated.
- Basic understanding of LLM evaluation concepts (e.g., groundedness, relevance) helpful but not required.
- Familiarity with Azure cost/billing constructs (e.g., cost management, budgets) helpful for the FinOps portion.

## How (format)

TBD — likely lecture + framework walkthrough (metrics, dashboards, review cadence).

## Lesson plan

TBD in detail. Likely coverage:

- Agent evaluations and quality gates
- Red teaming
- Cost monitoring and FinOps practices for agentic workloads
- Telemetry and KPI reviews
- Continuous assessment cadence

## Key concepts

Evaluation metrics (groundedness, relevance, fluency, coherence), quality gates, red teaming, FinOps for AI workloads, token-based cost accounting, KPI/telemetry dashboards, review cadence.

Related content: `Azure AI Foundry Governance.PPTX` (internal deck referenced in the planning call) — TBD to confirm relevance/reuse for this session vs. Day 4.

## Deliverable

An observability plan with priority signals and review cadence.

## Builds on

[Day 2 — Build & Deploy an Agent, Agent Observability](../day-2/README.md): evaluation and cost measurement here are applied to the hosted, instrumented agent deployed and observed in that session.

## Feeds into

[Day 4 — Agent Governance and Security](../day-4/README.md) relies on the evaluation signals and review cadence established here as inputs to governance controls and guardrails.

## Resources

See [docs/](docs/README.md). TBD — pending finalized decks and confirmation of the governance deck's overlap with this session.
