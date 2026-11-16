"""Tiny local MCP server (stdio) exposing Maple mortgage helpers. Run: python mcp_loan_server.py"""
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1]))
from mcp.server.mcpserver import MCPServer  # noqa: E402

from shared import fsi_common as f  # noqa: E402

mcp = MCPServer("northwind-loan-tools")


@mcp.tool()
def document_checklist(employment_type: str) -> list[str]:
    """Documents required for a mortgage application (salaried, self-employed, retired)."""
    return f.get_document_checklist(employment_type)


@mcp.tool()
def indicative_rate(term_years: int, credit_band: str, ltv_pct: float) -> dict:
    """Indicative (non-binding) fixed rate quote."""
    return f.get_rate_quote(term_years, credit_band, ltv_pct)


if __name__ == "__main__":
    mcp.run(transport="stdio")
