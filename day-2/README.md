# Day 2 — Build and Deploy an Agent, Agent Observability (Hosted Agents)

**Date:** TBD (proposed 2nd in series; original planning calendar listed this as "Session 3," dated Wednesday, October 7, 2026)
**Series:** [FSI Foundry Day Series](../README.md) · Previous: [day-1](../day-1/README.md) · Next: [day-3](../day-3/README.md)

## What

From use case to production-ready deployment: building an agent on Microsoft Foundry, deploying it as a hosted agent, and instrumenting it for observability.

## Why (FSI relevance)

Regulated customers need a repeatable, auditable path from prototype to production — not ad-hoc deployment. Observability (tracing, runtime monitoring) is the foundation that later Evaluations/FinOps (day-3) and Governance/Security (day-4) sessions depend on.

## Audience

Primary: AI/ML Engineers, Application Developers, Platform Engineering / DevOps.
Also relevant to: Enterprise Architects tracking deployment patterns, SRE/Ops teams who will operate hosted agents in production.

## Prerequisites

- Completion of [Day 1](../day-1/README.md), or working knowledge of the landing-zone/network/identity foundation agents will be deployed onto.
- General programming experience (Python or C#) and familiarity with REST APIs.
- Basic familiarity with the Azure AI Foundry portal/SDK helpful but not required.

## How (format)

TBD — likely lecture + live build/deploy walkthrough.

## Lesson plan

TBD in detail. Likely coverage, based on Foundry deep-dive materials:

- Prompt agents vs. hosted agents
- Deployment approaches and tool integrations
- Agent identities
- Runtime monitoring and tracing
- Agent operations basics

## Key concepts

Prompt agent vs. hosted agent, tool/function calling, agent identity (managed identity for agents), deployment pipelines, distributed tracing, OpenTelemetry, runtime monitoring.

## Deliverable

A working deployment approach and launch checklist (production deployment checklist / launch readiness guide).

## Builds on

[Day 1 — AI Landing Zone + Networking](../day-1/README.md): agents in this session are deployed onto the governed platform and secure network/identity foundation established there.

## Feeds into

[Day 3 — Evaluations and FinOps](../day-3/README.md) uses the deployed, observable agent from this session as the subject of quality, reliability, and cost measurement.

## Resources

See [docs/](docs/README.md). TBD — pending finalized decks, recordings, and demo materials.
