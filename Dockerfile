# Start from a lightweight Python image
FROM python:3.11-slim

# Install uv (the MCP transport), mcp-alchemy, and the Postgres driver
RUN pip install --no-cache-dir \
      uv \
      mcp-alchemy==2025.6.19.201831 \
      psycopg2-binary

WORKDIR /app

# Expose the default port for clarity
EXPOSE 8000

# Use shell form so that $PORT is interpolated at runtime
ENTRYPOINT ["/bin/sh", "-c"]
CMD uvx \
      --transport http \
      --http-port ${PORT:-8000} \
      --http-path /mcp \
      --from mcp-alchemy==2025.6.19.201831 \
      --with psycopg2-binary \
      --refresh-package mcp-alchemy \
      mcp-alchemy
