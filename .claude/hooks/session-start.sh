#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PORT=8080

# Kill any existing server on the port
fuser -k ${PORT}/tcp 2>/dev/null || true

# Start HTTP server in background from project root
python3 -m http.server ${PORT} --directory "$CLAUDE_PROJECT_DIR" &>/tmp/http-server.log &

echo "App server started on http://localhost:${PORT}"
