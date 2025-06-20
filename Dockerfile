# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# install FastAPI, Uvicorn and MCP-Alchemy + your DB driver
RUN pip install \
      flask \
      uvicorn[standard] \
      mcp-alchemy==2025.6.19.201831 \
      psycopg2-binary

# copy our wrapper
COPY entrypoint.py .

# Expose the port and launch via Gunicorn
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "entrypoint:app"]
