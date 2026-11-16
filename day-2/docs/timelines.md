# Day 2 — Timeline: Build and Deploy an Agent

**Format:** Instructor-led, hands-on notebooks, 2 hours (Maple Mortgage Assistant case study). Pre-work: instructor runs `scripts/deploy.sh` once; learners `az login` and install the venv.

| Time | Block | Notebook | Covers |
|------|-------|----------|--------|
| 0:00-0:10 | Framing | - | Northwind Home Lending case, compliance needs, [architecture](architecture.md) |
| 0:10-0:30 | Build an agent | 01 | Code agent, streaming, sessions, prompt agent in Foundry, local Responses host |
| 0:30-0:50 | Tools and MCP | 02 | Function tools, approval gate, MCP (remote, local, server-side), connections, toolbox |
| 0:50-1:05 | Knowledge and memory | 03, 04 | Foundry IQ grounding with citations; memory store, scopes, erasure |
| 1:05-1:15 | Skills | 05 | Approved-skills registry, Foundry skills |
| 1:15-1:35 | Evaluation and release gate | 06 | Traces, evaluators, gate: v1 pass, v2 blocked |
| 1:35-1:50 | Deploy | 07 | Hosted agent (pre-build the image, ~8 min), rollout, rollback |
| 1:50-2:00 | Design activity and wrap-up | templates | Fill in blueprint and readiness checklist; preview Day 3 |

Run notebooks serially to avoid 429s.
