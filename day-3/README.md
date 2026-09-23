# Day 3 — Evaluations and FinOps

**Date:** TBD (proposed 3rd in series; original planning calendar listed this as "Session 4," dated Wednesday, November 4, 2026)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-2](../day-2/README.md) · Next: [day-4](../day-4/README.md)

## What

Measuring agent quality, reliability, cost, and operational health. Kept as a dedicated session, deliberately separate from Day 2's observability content, because governance and guardrails (Day 4) depend specifically on evaluation results.

## Why

Regulated customers require demonstrable quality gates and cost accountability before agents can be trusted in production. This session gives platform/ops teams the operational cadence needed to sustain that trust over time.

**Key concepts:** Evaluation metrics (groundedness, relevance, fluency, coherence), quality gates, red teaming, FinOps for AI workloads, token-based cost accounting, KPI/telemetry dashboards, review cadence.

Related content: `Azure AI Foundry Governance.PPTX` (internal deck referenced in the planning call) — TBD to confirm relevance/reuse for this session vs. Day 4.

## Audience

Primary: Data Scientists / ML Engineers, FinOps & Cloud Cost Management, Platform Operations teams.
Also relevant to: Enterprise Architects, Governance/Risk stakeholders who consume evaluation signals as inputs to Day 4 controls.

## Prerequisites

- Completion of [Day 2](../day-2/README.md): a deployed, observable/instrumented agent is the subject being evaluated.
- Basic understanding of LLM evaluation concepts (e.g., groundedness, relevance) helpful but not required.
- Familiarity with Azure cost/billing constructs (e.g., cost management, budgets) helpful for the FinOps portion.

## Format

Lecture + framework walkthrough (metrics, dashboards, review cadence).

## Lesson plan

Confirmed at the 2026-09-23 follow-up call ("measure quality, reliability, cost, and operational health" — the group reiterated elevating evaluations as its own major topic, distinct from Day 2's observability content):

- Agent evaluations
- Quality measurement
- Reliability assessment
- Cost management
- Operational reviews
- Continuous improvement loops

Additional supporting coverage carried over from prior material:

- Quality gates and red teaming
- Telemetry and KPI reviews
- Token-based cost accounting / FinOps for agentic workloads

## Deliverable

An observability plan with priority signals and review cadence.

## Recap

[Day 2](../day-2/README.md) delivered a hosted, instrumented agent in production. This session evaluates that agent's quality, reliability, and cost.

## Resources

See [docs/](docs/). TBD — pending finalized decks and confirmation of the governance deck's overlap with this session.
