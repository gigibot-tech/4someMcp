# Use a slim Python base
FROM python:3.11-slim

# install uvx and your MCP package
RUN pip install --no-cache-dir uvx mcp-alchemy==2025.6.19.201831 psycopg2-binary

# expose default HTTP port (optional, for clarity)
EXPOSE 8000

# run the MCP server via UVX
CMD ["uvx",
     "--from", "mcp-alchemy==2025.6.19.201831",
     "--with", "psycopg2-binary",
     "--refresh-package", "mcp-alchemy",
     "mcp-alchemy"]
