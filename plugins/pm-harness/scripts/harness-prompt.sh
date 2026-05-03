#!/bin/bash
set -euo pipefail

read_timeout=60
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

if [ ! -d "$PROJECT_DIR/docs/harness" ]; then
  exit 0
fi

# Not interactive — skip the prompt silently
if [ ! -t 0 ]; then
  exit 0
fi

echo ""
echo "============================================"
echo "  docs/harness/ ready"
echo "  harness-update skill  |  @harness-reviewer agent"
echo "============================================"
read -p "  End of session — save learnings to docs/harness/? (y/n) " -n 1 -r -t "$read_timeout" || true
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo '{"decision": "block", "reason": "User wants to save session learnings", "systemMessage": "Use the harness-update skill to capture actionable knowledge from this session. Write per-topic files to docs/harness/troubleshooting/ or docs/harness/decisions/, and update docs/harness/index.md with new entries and when-to-check guidance. Apply quality gate before writing. Ask the user to confirm when done, then stop."}'
else
  echo '{"decision": "allow", "reason": "User declined to save learnings"}'
  exit 0
fi