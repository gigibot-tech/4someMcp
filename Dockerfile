# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# install uvicorn + mcp-alchemy + chosen DB driver
RUN pip install \
      uvicorn[standard] \
      mcp-alchemy==2025.6.19.201831 \
      psycopg2-binary

# copy our wrapper
COPY entrypoint.py .

# expose default port
EXPOSE 8000

# run it
CMD ["uvicorn", "entrypoint:main_app", "--host", "0.0.0.0", "--port", "8000"]
