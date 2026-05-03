#!/usr/bin/env bats

HOOK_SCRIPT="$(dirname "$BATS_TEST_DIRNAME")/plugins/pm-harness/scripts/harness-prompt.sh"

setup() {
  TMP_PROJECT="$(mktemp -d)"
}

teardown() {
  rm -rf "$TMP_PROJECT"
}

run_hook() {
  local dir="$1"
  local user_input="${2:-}"
  CLAUDE_PROJECT_DIR="$dir" bash "$HOOK_SCRIPT" <<< "$user_input" 2>/dev/null || true
}

@test "allow: no docs/dev directory → exit 0" {
  output=$(run_hook "$TMP_PROJECT" "n")
  [[ -z "$output" || "$output" == *"Skipped"* ]]
}

@test "block: docs/dev exists + user says y → block decision" {
  mkdir -p "$TMP_PROJECT/docs/dev"
  output=$(run_hook "$TMP_PROJECT" "y")
  [[ "$output" == *'"decision": "block"'* ]]
}

@test "allow: docs/dev exists + user says n → exit 0" {
  mkdir -p "$TMP_PROJECT/docs/dev"
  output=$(run_hook "$TMP_PROJECT" "n")
  [[ "$output" == *"Skipped"* || -z "$output" ]]
}

@test "fallback: CLAUDE_PROJECT_DIR unset uses pwd" {
  mkdir -p "$TMP_PROJECT/docs/dev"
  (
    cd "$TMP_PROJECT"
    unset CLAUDE_PROJECT_DIR
    output=$(bash "$HOOK_SCRIPT" 2>/dev/null <<< "n" || true)
    [[ "$output" == *"Skipped"* || -z "$output" ]]
  )
}