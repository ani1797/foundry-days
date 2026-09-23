# Day 2 — Build and Deploy an Agent, Agent Observability (Hosted Agents)

**Date:** TBD (proposed 2nd in series; original planning calendar listed this as "Session 3," dated Wednesday, October 7, 2026)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-1](../day-1/README.md) · Next: [day-3](../day-3/README.md)

## What

From use case to production-ready deployment: building an agent on Microsoft Foundry, deploying it as a hosted agent, and instrumenting it for observability.

## Why

Regulated customers need a repeatable, auditable path from prototype to production — not ad-hoc deployment. Observability (tracing, runtime monitoring) is the foundation that later Evaluations/FinOps (day-3) and Governance/Security (day-4) sessions depend on.

**Key concepts:** Prompt agent vs. hosted agent, tool/function calling, agent identity (managed identity for agents), deployment pipelines, distributed tracing, OpenTelemetry, runtime monitoring.

## Audience

Primary: AI/ML Engineers, Application Developers, Platform Engineering / DevOps.
Also relevant to: Enterprise Architects tracking deployment patterns, SRE/Ops teams who will operate hosted agents in production.

## Prerequisites

- Completion of [Day 1](../day-1/README.md), or working knowledge of the landing-zone/network/identity foundation agents will be deployed onto.
- General programming experience (Python or C#) and familiarity with REST APIs.
- Basic familiarity with the Azure AI Foundry portal/SDK helpful but not required.

## Format

Lecture + live build/deploy walkthrough.

## Lesson plan

Confirmed at the 2026-09-23 follow-up call ("move from business scenario to production deployment"):

- Agent development
- Hosted agents
- Production deployment
- Operational readiness
- Foundry observability
- Monitoring patterns
- "Read + Observe" operational model

Additional supporting coverage carried over from prior Foundry deep-dive material:

- Prompt agents vs. hosted agents
- Deployment approaches and tool integrations
- Agent identities
- Distributed tracing / OpenTelemetry
- Agent operations basics

## Deliverable

A working deployment approach and launch checklist (production deployment checklist / launch readiness guide).

## Recap

[Day 1](../day-1/README.md) delivered the governed landing-zone platform foundation and secure network/identity patterns. Agents in this session are deployed onto that foundation.

## Resources

See [docs/](docs/). TBD — pending finalized decks, recordings, and demo materials.
