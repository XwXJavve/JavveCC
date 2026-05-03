#!/bin/bash
set -euo pipefail

jq -n '{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny"
  },
  "systemMessage": "WebSearch and WebFetch are disabled. Use Tavily MCP for web search or curl via Bash for fetching URLs."
}'
