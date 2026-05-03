#!/usr/bin/env bats

HOOK_SCRIPT="$(dirname "$BATS_TEST_DIRNAME")/plugins/dev-kit/scripts/block-dotenv.sh"

run_hook() {
  local input="$1"
  echo "$input" | bash "$HOOK_SCRIPT" 2>/dev/null || true
}

# ── deny cases ──

@test "deny: .env at root" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: src/.env (subdirectory)" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":"src/.env"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.local" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env.local"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.production" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env.production"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.development" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env.development"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.test in subdir" {
  output=$(run_hook '{"tool_name":"Edit","tool_input":{"file_path":"backend/.env.test"}}')
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

# ── allow cases ──

@test "allow: .env.example" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env.example"}}')
  [[ -z "$output" ]]
}

@test "allow: .env.sample" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":".env.sample"}}')
  [[ -z "$output" ]]
}

@test "allow: regular file (db.ts)" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":"config/db.ts"}}')
  [[ -z "$output" ]]
}

@test "allow: package.json" {
  output=$(run_hook '{"tool_name":"Edit","tool_input":{"file_path":"package.json"}}')
  [[ -z "$output" ]]
}

@test "allow: empty file_path" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{"file_path":""}}')
  [[ -z "$output" ]]
}

@test "allow: no file_path key" {
  output=$(run_hook '{"tool_name":"Read","tool_input":{}}')
  [[ -z "$output" ]]
}

# ── robustness ──

@test "robust: malformed JSON does not crash" {
  output=$(run_hook 'not json at all')
  [[ -z "$output" || "$output" == *'"permissionDecision":"allow"'* ]]
}

@test "robust: empty stdin" {
  output=$(run_hook '')
  [[ -z "$output" || "$output" == *'"permissionDecision":"allow"'* ]]
}
