import os
import json
import subprocess
from flask import Flask, request, Response

app = Flask(__name__)

UVX_CMD = [
    "uvx",
    "--from", "mcp-alchemy==2025.6.19.201831",
    "--with", "psycopg2-binary",
    "--refresh-package", "mcp-alchemy",
    "mcp-alchemy"
]

@app.route("/mcp", methods=["POST"])
def mcp_proxy():
    # Read the incoming MCP call
    payload = request.get_data()
    # Spawn the MCP Alchemy CLI, feed it the JSON over stdin
    proc = subprocess.Popen(
        UVX_CMD,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = proc.communicate(payload)
    if proc.returncode != 0:
        return Response(stderr, status=500, mimetype="text/plain")
    return Response(stdout, status=200, mimetype="application/json")

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    app.run(host="0.0.0.0", port=port)
