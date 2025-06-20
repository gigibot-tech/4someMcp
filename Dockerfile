# Dockerfile
FROM python:3.11-slim

# 1) Create a non-root user (optional but recommended)
RUN addgroup --system app && adduser --system --ingroup app app
USER app

# 2) Workdir
WORKDIR /home/app

# 3) Install MCP Alchemy + SQL driver
#    - no need to install `uvx` or `uv`; MCP Alchemy will detect HTTP transport
RUN pip install --no-cache-dir \
      mcp-alchemy==2025.6.19.201831 \
      psycopg2-binary

# 4) Expose the default MCP HTTP port
EXPOSE 8000

# 5) Tell MCP Alchemy where your DB lives
#    (Railway: set this in the Dashboard → Variables)

# 6) Run the built-in MCP Alchemy server (HTTP transport on /mcp)
ENTRYPOINT ["python", "-m", "mcp_alchemy.server"]
# by default it will read DB_URL, start on 0.0.0.0:8000, 
# and mount the MCP endpoint at `POST /mcp`

# (If you need to change host/port you can append `--host 0.0.0.0 --port 8000` here)
