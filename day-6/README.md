# Day 6 — Microsoft Agent Framework Deep Dive (A2A, Foundry vs. Copilot Studio, Decision Matrix)

**Date:** TBD (proposed 6th and closing session in series, targeting March)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-5](../day-5/README.md)

## What

The closing session, addressing recurring customer architecture questions directly: Foundry or Copilot Studio? When to use each? How do MCP, A2A, Skills, and Connectors fit together? Covers the Microsoft Agent Framework, A2A patterns, MCP patterns, Skills architecture, Connector architecture, and a Foundry vs. Copilot Studio decision matrix.

## Why

By this point, FSI customers have built, deployed, evaluated, governed, and grounded agents — but still need a clear framework for choosing the right architecture for new use cases going forward. This session closes the series by turning everything learned into durable decision criteria.

**Key concepts:** Microsoft Agent Framework, Agent-to-Agent (A2A) protocol, Model Context Protocol (MCP), Skills architecture, Connector architecture, Foundry vs. Copilot Studio decision criteria.

## Audience

Primary: Enterprise Architects, Technology Leaders / Program Sponsors, Application Developers.
Also relevant to: Platform Engineering teams and any role that attended earlier sessions, since this closing session ties the whole series together.

## Prerequisites

- Completion of Days 1–5, or equivalent working familiarity with the full agent lifecycle (platform foundation → build/deploy → evaluation/observability/FinOps → governance → knowledge grounding).
- Basic understanding of agent architecture patterns (tools, orchestration, connectors) helpful.

## Format

TBD — likely lecture + decision-matrix workshop, 2 hours, driven by recurring customer architecture questions.

## Lesson plan

Draft block-by-block agenda (unconfirmed): [docs/timelines.md](docs/timelines.md).

Still an **open idea, not yet a final decision** — a dedicated Microsoft Agent Framework / MCP / A2A deep dive is a possible extension of the series, alongside a separately proposed (also not finalized) Product Group roadmap session. Likely coverage if confirmed:

- Microsoft Agent Framework overview and A2A (agent-to-agent) patterns
- MCP patterns, Skills architecture, Connector architecture
- Open-source framework interop considerations
- Foundry vs. Copilot Studio decision matrix walkthrough
- Possible Product Group roadmap segment (guest speakers, NDA/public roadmap) — TBD, separate open idea

**Open item:** whether this content is absorbed into Day 5 instead of staying separate — undecided.

## Deliverable

- **Artifact:** Architecture decision matrix (Foundry vs. Copilot Studio, and when to use A2A/MCP/Skills/Connectors).
- **Take-home assets:** [`templates/decision-matrix.md`](templates/decision-matrix.md), [`templates/framework-comparison.md`](templates/framework-comparison.md) (draft).

## Recap

[Day 5](../day-5/README.md) delivered a prioritized Microsoft IQ adoption scenario, applied within the governance model from [Day 4](../day-4/README.md). This session uses those grounding/knowledge and governance patterns as input to the architecture decisions made here.

## Resources

See [docs/](docs/) and [docs/timelines.md](docs/timelines.md) (draft), and [templates/](templates/) for draft take-home templates. TBD — pending finalized decks.
