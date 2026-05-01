#!/bin/bash
set -euo pipefail

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')

if [ "$tool_name" = "WebSearch" ]; then
  query=$(echo "$input" | jq -r '.tool_input.query // ""')
  jq -n --arg q "$query" '{
    "permissionDecision": "deny",
    "systemMessage": "Use Tavily for web search queries. Search for: " + $q
  }'
  exit 0
fi

if [ "$tool_name" = "WebFetch" ]; then
  url=$(echo "$input" | jq -r '.tool_input.url // ""')
  jq -n --arg u "$url" '{
    "permissionDecision": "deny",
    "systemMessage": "Do not use WebFetch. Use curl via Bash instead. URL: " + $u
  }'
  exit 0
fi
