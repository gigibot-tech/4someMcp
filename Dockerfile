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

EXPOSE 8000

CMD ["uvicorn", "entrypoint:main_app", "--host", "0.0.0.0", "--port", "8000"]
