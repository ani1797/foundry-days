# Deployment Readiness Checklist

Each item maps to a notebook. Tick only with evidence.

- [ ] Success criteria defined and agreed with stakeholders (06)
- [ ] Eval dataset covers primary, edge and refusal cases; custom evaluators for policy rules, e.g. no rate guarantee (06)
- [ ] Release gate: thresholds set and enforced in code; a failing version is blocked (06, 07)
- [ ] Tracing to App Insights enabled; no PII or secrets in traces (06)
- [ ] Failure handling: tool errors, missing knowledge, "I don't know", human escalation with approval (02, 03)
- [ ] Memory scope, retention and erasure tested (04)
- [ ] Only approved, hash-pinned skills loaded (05)
- [ ] Versioning for prompts, tools, skills and model; image tagged by version (01, 07)
- [ ] Identity: managed identity, least-privilege roles, local auth disabled, no keys (bicep, 07)
- [ ] Rollout smoke test passes after the switch (07)
- [ ] Rollback tested and documented (07)
- [ ] Cleanup of non-prod assets confirmed (`scripts/teardown.sh`)
