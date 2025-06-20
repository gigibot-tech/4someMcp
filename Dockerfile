FROM python:3.11-slim

# copy your minimal files (here just requirements.txt)
WORKDIR /app
COPY requirements.txt .

# install
RUN pip install --no-cache-dir -r requirements.txt

# expose default port
EXPOSE 8000

# run the MCP
CMD ["uvx",
     "--from", "mcp-alchemy==2025.6.19.201831",
     "--with", "psycopg2-binary",
     "--refresh-package", "mcp-alchemy",
     "mcp-alchemy"]
