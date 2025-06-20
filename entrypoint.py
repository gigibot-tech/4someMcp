# entrypoint.py
from fastapi import FastAPI
from mcp_alchemy.server import app as mcp_app

main_app = FastAPI(
    title="MCP-Alchemy on Railway",
    description="Wrapper mounting mcp-alchemy at /mcp"
)

# mount the existing MCP-Alchemy app at /mcp
main_app.mount("/mcp", mcp_app)

@main_app.get("/")
async def root():
    return {"message": "MCP-Alchemy wrapper is up. → POST to /mcp"}

# if you want an explicit health-check endpoint
@main_app.get("/health")
async def health():
    return {"status": "healthy"}
