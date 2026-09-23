# FSI Foundry Day Series — Agentic Operations on Microsoft Foundry

A multi-month, curated learning journey for **Financial Services & Insurance (FSI)** customers, taking them from a governed AI platform foundation through to production agent operations on **Microsoft Foundry**.

Organizing Committee:
Asmita Usturge, Owais Hashmi, Mariusz Kolodziej, Anirudh Aggarwal.

## Objectives

- Build practical, hands-on knowledge across the full agent lifecycle: platform foundation → networking/security → build & deploy → observability → evaluation/FinOps → governance → knowledge grounding (Microsoft IQ) → framework/architecture decisions.
- Target regulated-industry (FSI) constraints throughout: identity, network isolation, auditability, cost control, and responsible AI.
- Every session ends with a **concrete customer artifact** (assessment, architecture, checklist, control map, backlog, or decision matrix) — not just slides.
- Maintain **continuity**: each session explicitly builds on the deliverables of the previous one, and call-outs/recaps tie the series together into one coherent story rather than standalone talks.

## Audience

Enterprise Architects, AI Platform teams, Cloud Platform teams, Security & Governance teams, developers building agents, and technology leaders sponsoring agent programs. Sessions are designed so different roles can join different days while a shared narrative connects the whole series. Target: **30–40 participants** from strategic FSI accounts.

## Status of scheduling

> **Note on dates:** The original planning-call calendar listed sessions out of prerequisite order (e.g., "Build & Deploy" dated before "AI Landing Zone," which it depends on). This repo orders sessions **logically** (curriculum order) instead. All dates below are marked **TBD**, proposed on a **monthly cadence** (the original calendar used a first-Wednesday-of-the-month rhythm, Oct 2026–Mar 2027) pending confirmation of room/sponsor logistics. See each day's README for the original reference date, where one existed.

## Roadmap

| Day | Theme | Date | Outcome / Deliverable |
|-----|-------|------|------------------------|
| [day-1](day-1/README.md) | AI Landing Zone + Microsoft Foundry Networking & Design | TBD (proposed 1st in series) | Landing-zone readiness assessment + prioritized implementation backlog; reference networking architecture + validation checkpoints |
| [day-2](day-2/README.md) | Build & Deploy an Agent, Agent Observability (Hosted Agents) | TBD (proposed 2nd) | Working deployment approach + launch checklist |
| [day-3](day-3/README.md) | Evaluations and FinOps | TBD (proposed 3rd) | Observability plan with priority signals + review cadence |
| [day-4](day-4/README.md) | Agent Governance and Security | TBD (proposed 4th) | Governance and security control map |
| [day-5](day-5/README.md) | Microsoft IQ | TBD (proposed 5th) | Prioritized Microsoft IQ adoption scenario |
| [day-6](day-6/README.md) | Microsoft Agent Framework Deep Dive — A2A, MCP, Foundry vs. Copilot Studio | TBD (proposed 6th, closing session) | Architecture decision matrix |

Each `day-N/` folder contains:
- `README.md` — what/why/how, lesson plan, deliverable, continuity links (TBD where details are not yet confirmed).
- `docs/` — slides, architecture diagrams, scripts, and other session materials (populate as they are produced).

## Roles & Owners

| Owner | Responsibility |
|-------|-----------------|
| Asmita Usturge | Sponsorship, planning, customer engagement |
| Owais Hashmi | Room booking, registration, logistics |
| Anirudh Aggarwal | Session agenda, landing-zone content, customer deliverables, speaker recruitment |
| Mariusz Kolodziej | Session refinement and planning support |
| Louis Law (proposed) | FSI sponsorship / industry support |

## Open action items (from planning call)

- [ ] Share October room availability
- [ ] Produce Microsoft-generic (non-Canada-specific) landing-zone content
- [ ] Create Teams registration workflow
- [ ] Secure FSI sponsorship
- [ ] Recruit Microsoft presenters for future sessions
- [ ] Schedule detailed follow-up planning session
- [ ] Confirm final dates for each day and update this README + day folders

## Curator agent

This repo includes a [`curator` custom agent](.github/agents/curator.agent.md) for GitHub Copilot CLI. Invoke it (`/agent curator`) to keep the series structured: it checks that each day has clear goals, deliverables, and continuity links to adjacent days, flags unresolved TBDs, and helps draft/update day content consistently.
