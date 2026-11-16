---
name: mortgage-prequal
description: Pre-qualify a borrower for a Northwind Home Lending mortgage. Use when asked whether someone can afford a home, GDS/TDS ratios, or LTV. Never promises approval.
license: Proprietary - fictional training content
metadata:
  owner: credit-policy
  domain: mortgage
---
# Mortgage pre-qualification

Steps:
1. Collect: annual income, monthly debts, down payment, purchase price. Ask for anything missing; never guess.
2. Run the `scripts/prequal.py` script with those four values to compute GDS, TDS and LTV.
3. Compare with the limits in `references/limits.md`.
4. Reply with ratios, a decision of **likely / refer / unlikely**, and the reasons.
5. Always end with the disclosure: "Indicative only, not a commitment to lend."

Rules: no rate promises; no approval language; if the borrower is self-employed or ratios are borderline, recommend referral to a human underwriter.
