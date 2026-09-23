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

## Roadmap

| Day | Theme | Date | Primary Audience | Outcome / Deliverable |
|-----|-------|------|-------------------|------------------------|
| [day-1](day-1/README.md) | AI Landing Zone + Microsoft Foundry Networking & Design | **October 15, 2026 (confirmed)**, 10:00 AM – 2:00 PM | Cloud Platform / Infrastructure teams, Network & Security Engineering, Enterprise Architects, Identity & Access Management | Landing-zone readiness assessment + prioritized implementation backlog; reference networking architecture + validation checkpoints |
| [day-2](day-2/README.md) | Build & Deploy an Agent, Agent Observability (Hosted Agents) | TBD (proposed 2nd) | AI/ML Engineers, Application Developers, Platform Engineering / DevOps, Enterprise Architects | Working deployment approach + launch checklist |
| [day-3](day-3/README.md) | Evaluations and FinOps | TBD (proposed 3rd) | Data Scientists / ML Engineers, FinOps & Cloud Cost Management, Platform Operations, Enterprise Architects | Observability plan with priority signals + review cadence |
| [day-4](day-4/README.md) | Agent Governance and Security | TBD (proposed 4th) | Security & Risk / CISO teams, Compliance & Governance, Identity & Access Management, Enterprise Architects | Governance and security control map |
| [day-5](day-5/README.md) | Microsoft IQ | TBD (proposed 5th) | Data & Knowledge Management teams, Application Developers, Enterprise Architects, Business/Domain SMEs | Prioritized Microsoft IQ adoption scenario |
| [day-6](day-6/README.md) | Microsoft Agent Framework Deep Dive — A2A, MCP, Foundry vs. Copilot Studio | TBD (proposed 6th, closing session) | Enterprise Architects, Technology Leaders / Program Sponsors, Application Developers, Platform Engineering | Architecture decision matrix |

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

## Logistics

- **Day 1 is scheduled for October 15, 2026, 10:00 AM – 2:00 PM.**
- Classroom setup to support laptops and hands-on exploration.
- Initial room capacity ~40, with overflow options; Teams bridge opened for remote attendees.
- Registration and waitlist capabilities will be used; November and December sessions will be auto-enrolled based on Day 1 demand. Additional sessions planned through March 2027.
- Series remains a **connected**, six-part curriculum (not standalone sessions): each day recaps the prior deliverable, adds a deep dive with FSI/Insurance examples, and ends with a customer takeaway.
- Every day's `README.md` links to a `docs/timelines.md` with a block-by-block session agenda for that day.
- Day 1 security scope was narrowed to high-level identity concepts only; a separate, dedicated security session (Agent 365, On-Behalf-Of, Foundry control-plane security) is a likely future addition — not yet on the roadmap.
- Cross-session FSI case study (e.g., a mortgage or insurance agent carried from Day 2 through observability, evaluation, and governance) is a proposed **stretch goal** to strengthen continuity — not yet a final decision.
- Day ordering opens with Landing Zone + Networking as the platform prerequisite for the rest of the series.

## Open ideas raised (not yet final decisions)

- Extend the series with a dedicated **Microsoft Agent Framework / MCP / A2A** deep dive (currently modeled as [day-6](day-6/README.md), pending confirmation).
- Invite **Product Group speakers** for roadmap segments in sessions (possibly a standalone future roadmap session).
- Convert the series content into a reusable blueprint/course after proving the format, adaptable beyond FSI.
- Potentially extend the series beyond March 2027 if adoption is strong.
- Whether Day 5 (Microsoft IQ) absorbs some MCP/A2A framework discussion instead of keeping it fully separate in Day 6 — undecided.

## Open action items

- [ ] Share October room availability
- [ ] Produce Microsoft-generic (non-Canada-specific) landing-zone content
- [ ] Create Teams registration workflow
- [ ] Secure FSI sponsorship
- [ ] Recruit Microsoft presenters for future sessions
- [ ] Schedule detailed follow-up planning session
- [ ] Confirm final dates for each day and update this README + day folders

## Curator agent

This repo includes a [`curator` custom agent](.github/agents/curator.agent.md) for GitHub Copilot CLI. Invoke it (`/agent curator`) to keep the series structured: it checks that each day has clear goals, deliverables, and continuity links to adjacent days, flags unresolved TBDs, and helps draft/update day content consistently.
