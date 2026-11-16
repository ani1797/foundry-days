"""Compute GDS/TDS/LTV. Usage: prequal.py <income> <monthly_debts> <down_payment> <price>"""
import json, sys

def run(income, monthly_debts, down, price):
    loan = price - down
    # fictional housing cost: P&I at 5% / 25y + 0.8% of price per year tax+heat
    r = 0.05 / 12; n = 300
    pmt = loan * r / (1 - (1 + r) ** -n)
    housing = pmt + price * 0.008 / 12
    gds = housing * 12 / income * 100
    tds = (housing + monthly_debts) * 12 / income * 100
    ltv = loan / price * 100
    if gds <= 39 and tds <= 44 and ltv <= 95: d = "likely"
    elif gds > 44 or tds > 49 or ltv > 95: d = "unlikely"
    else: d = "refer"
    return {"gds_pct": round(gds, 1), "tds_pct": round(tds, 1), "ltv_pct": round(ltv, 1), "decision": d,
            "disclosure": "Indicative only, not a commitment to lend."}

if __name__ == "__main__":
    a = [float(x) for x in sys.argv[1:5]]
    print(json.dumps(run(*a)))
