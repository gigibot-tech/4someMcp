# Dockerfile

# 1. Use a slim Python base
FROM python:3.11-slim

# 2. Set working dir
WORKDIR /app

# 3. Install runtime dependencies
#    - uvicorn (for ASGI)
#    - mcp-alchemy
#    - your SQL driver (e.g. psycopg2-binary for Postgres)
RUN pip install --no-cache-dir \
    uvicorn \
    mcp-alchemy==2025.6.19.201831 \
    psycopg2-binary

# 4. Expose the port (Railway will map it from $PORT)
EXPOSE 8000

# 5. Entrypoint: launch the built‐in FastAPI app
CMD ["uvicorn", "mcp_alchemy.server:app", "--host", "0.0.0.0", "--port", "8000"]
