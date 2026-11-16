---
name: adverse-action-letter
description: Draft an adverse action (decline) notice for a mortgage applicant. Use when an application is declined or counter-offered and a compliant letter is needed.
metadata:
  owner: compliance
  domain: mortgage
---
# Adverse action letter

1. Confirm the decision was made by a human underwriter (case id required). If not, refuse and escalate.
2. Read `references/template.md` and fill in the applicant first name, case id and up to 4 principal reasons (plain language, no internal scores).
3. Never mention protected characteristics. Never disclose model or rule internals.
4. Output a DRAFT only, labelled "Draft for compliance review".
