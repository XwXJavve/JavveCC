#!/usr/bin/env bats

HOOK_SCRIPT="$(dirname "$BATS_TEST_DIRNAME")/plugins/dev-kit/scripts/block-dotenv.sh"

# ── deny cases ──

@test "deny: .env at root" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: src/.env (subdirectory)" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":"src/.env"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.local" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env.local"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.production" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env.production"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.development" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env.development"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

@test "deny: .env.test in subdir" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Edit","tool_input":{"file_path":"backend/.env.test"}}'
  [[ "$output" == *'"permissionDecision": "deny"'* ]]
}

# ── allow cases ──

@test "allow: .env.example" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env.example"}}'
  [[ -z "$output" ]]
}

@test "allow: .env.sample" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":".env.sample"}}'
  [[ -z "$output" ]]
}

@test "allow: regular file (db.ts)" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":"config/db.ts"}}'
  [[ -z "$output" ]]
}

@test "allow: package.json" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Edit","tool_input":{"file_path":"package.json"}}'
  [[ -z "$output" ]]
}

@test "allow: empty file_path" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{"file_path":""}}'
  [[ -z "$output" ]]
}

@test "allow: no file_path key" {
  run bash "$HOOK_SCRIPT" <<< '{"tool_name":"Read","tool_input":{}}'
  [[ -z "$output" ]]
}

# ── robustness ──

@test "robust: malformed JSON does not crash" {
  run bash "$HOOK_SCRIPT" <<< 'not json at all'
  [[ -z "$output" || "$output" == *'"permissionDecision":"allow"'* ]]
}

@test "robust: empty stdin" {
  run bash "$HOOK_SCRIPT" <<< ''
  [[ -z "$output" || "$output" == *'"permissionDecision":"allow"'* ]]
}
