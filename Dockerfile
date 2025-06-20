FROM python:3.11-slim

# Install uvx, MCP-Alchemy and its DB driver
RUN pip install --no-cache-dir uv mcp-alchemy==2025.6.19.201831 psycopg2-binary

# Expose if you like
EXPOSE 8000

# Start the MCP server
CMD ["uvx","--from","mcp-alchemy==2025.6.19.201831","--with","psycopg2-binary","--refresh-package","mcp-alchemy","mcp-alchemy"]
