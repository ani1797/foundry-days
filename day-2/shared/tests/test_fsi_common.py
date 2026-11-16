from shared import fsi_common as f


def test_redact():
    t = f.redact("a@b.com 416-555-0142 123-456-789 4111 1111 1111 1111")
    assert "@" not in t and "0142" not in t and "123-456" not in t and "4111" not in t


def test_rate_and_prequal():
    q = f.get_rate_quote(5, "good", 70)
    assert q["rate_pct"] == 4.79 and q["indicative"] and q["disclosure"]
    assert f.prequalify(150000, 500, 100000, 500000)["decision"] in {"likely", "refer", "unlikely"}
    assert f.prequalify(40000, 2000, 5000, 600000)["decision"] == "unlikely"


def test_checklist_customer_escalate():
    assert "Business registration or articles of incorporation" in f.get_document_checklist("self-employed")
    c = f.lookup_customer("C-1001")
    assert "123-456" not in str(c) and "@example" in c["email"]
    assert f.escalate_to_underwriter("X", "r")["status"] == "queued"


def test_tools():
    assert len(f.TOOLS) == 5
