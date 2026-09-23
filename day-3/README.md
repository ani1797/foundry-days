# Day 3 — Evaluations and FinOps (incl. Agent Observability)

**Date:** TBD (proposed 3rd in series, targeting December)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-2](../day-2/README.md) · Next: [day-4](../day-4/README.md)

## What

How the Day 2 agent behaves in development and production: observability (telemetry, traces, quality/cost/safety signals), evaluation (quality gates, red teaming), and FinOps (token-based cost accounting, budget management). Kept as one dedicated session because Day 4's governance controls depend directly on these evaluation and observability signals.

## Why

Regulated customers require demonstrable quality gates and cost accountability before agents can be trusted in production. This session gives platform/ops teams the operational cadence needed to sustain that trust over time.

**Key concepts:** Telemetry, distributed tracing, evaluation metrics (groundedness, relevance, fluency, coherence), quality gates, red teaming, root-cause analysis, FinOps for AI workloads, token-based cost accounting, alert thresholds, review cadence.

Related content: `Azure AI Foundry Governance.PPTX` (internal deck) — TBD to confirm relevance/reuse for this session vs. Day 4.

## Audience

Primary: Data Scientists / ML Engineers, FinOps & Cloud Cost Management, Platform Operations teams.
Also relevant to: Enterprise Architects, Governance/Risk stakeholders who consume evaluation signals as inputs to Day 4 controls.

## Prerequisites

- Completion of [Day 2](../day-2/README.md): a deployed agent is the subject being observed and evaluated.
- Basic understanding of LLM evaluation concepts (e.g., groundedness, relevance) helpful but not required.
- Familiarity with Azure cost/billing constructs (e.g., cost management, budgets) helpful for the FinOps portion.

## Format

Lecture + framework walkthrough (metrics, dashboards, review cadence), 2 hours.

## Lesson plan

Full block-by-block agenda: [docs/timelines.md](docs/timelines.md).

- Observability model: telemetry, traces, quality indicators, cost signals, user feedback
- Monitoring and evaluation demonstration: follow agent interactions, inspect signals, evaluation metrics, quality gates, red teaming, root-cause analysis
- Operational response and FinOps: alert thresholds, triage, regression detection, continuous evaluation, token-based cost accounting
- Guided planning activity: build an observability scorecard (signal ownership, thresholds, review cadence, cost dashboard)

## Deliverable

- **Artifact:** Observability scorecard with priority signals and review cadence.
- **Take-home assets:** [`templates/observability-scorecard.md`](templates/observability-scorecard.md), [`templates/evaluation-test-cases.md`](templates/evaluation-test-cases.md), [`finops/cost-dashboard-query.kql`](finops/cost-dashboard-query.kql).

## Recap

[Day 2](../day-2/README.md) delivered a deployed agent. This session observes and evaluates that agent's quality, reliability, and cost.

## Resources

See [docs/](docs/) and [docs/timelines.md](docs/timelines.md) for materials, and [templates/](templates/) and [finops/](finops/) for take-home templates. TBD — pending finalized decks and confirmation of the governance deck's overlap with this session.
