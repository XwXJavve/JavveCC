#!/bin/bash
set -euo pipefail

command -v jq >/dev/null || { jq -n '{"hookSpecificOutput":{"permissionDecision":"allow"},"systemMessage":"block-dotenv: jq not found, skipping"}' ; exit 0; }

input=$(cat 2>/dev/null || echo '{}')
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')
basename="${file_path##*/}"

if [[ "$basename" =~ ^\.env(\..+)?$ ]]; then
  if [[ "$basename" == ".env.example" || "$basename" == ".env.sample" ]]; then
    exit 0
  fi
  jq -n '{
    "hookSpecificOutput": {
      "permissionDecision": "deny"
    },
    "systemMessage": "Do not read or modify .env directly. If a new environment variable is needed, add it to .env.example with a placeholder value, then tell the user to sync it to their .env manually."
  }'
  exit 0
fi
