# Day 1 — Bicep Templates

One subfolder per supported Microsoft Foundry network setup. Each contains a deployable `main.bicep` plus a `README.md` describing when to use that pattern and which parameters need to be filled in for a given environment.

| Folder | Setup | When to use |
|--------|-------|-------------|
| [`basic-foundry/`](basic-foundry/) | Public network, managed-identity only | Dev/sandbox exploration, no regulated data |
| [`network-isolated-foundry/`](network-isolated-foundry/) | Private endpoints + VNET injection, no public ingress/egress | Standard FSI production pattern |
| [`hub-spoke-foundry/`](hub-spoke-foundry/) | Hub-and-spoke topology, shared connectivity/DNS across multiple Foundry projects | Enterprise landing zone with multiple business units/workloads sharing network services |

All templates are starting points for the session's hands-on deployment walkthrough and readiness-assessment activity — parameter values marked `TBD` must be set per customer environment before deployment.
