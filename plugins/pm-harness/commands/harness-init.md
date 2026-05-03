---
name: harness-init
description: Initialize the project harness — launches @harness-setup to read the codebase and create files, then @harness-reviewer to validate
argument-hint: <project-name>
---

Initialize the project harness for **$ARGUMENTS**. This command orchestrates a multi-agent workflow: check existing state, gather user input, delegate to @harness-setup for file creation, then @harness-reviewer for validation.

## Core Principles

- **Minimal viable harness:** CLAUDE.md should stay under 100 lines. Only the essentials go in the entry point; everything else lives in `docs/harness/`.
- **Discover, don't invent:** Both agents must ground their output in what the project files actually say, not assumptions.
- **Validate after creation:** Every file created must be verified — no blind delegation.

Use TodoWrite to track progress through all phases.

---

## Phase 1: Preflight

**Goal:** Assess what already exists and gather user input before any agent work.

1. Run `ls docs/harness/ 2>/dev/null` and `cat CLAUDE.md 2>/dev/null` to see current state.
2. Report what exists and what's missing.
3. Explain briefly: *"@harness-setup will read the project to infer the stack and conventions, create CLAUDE.md and docs/harness/."*
4. **Ask the user:** *"Any non-obvious rules Claude should follow from session start? (Things the codebase can't tell it.)"*
   - If they provide rules, pass them to @harness-setup.
   - If not, the agent will infer what it can.

Determine which mode to run:

| CLAUDE.md state | Action |
|---|---|
| Does not exist | Full setup: create everything |
| Exists, no `## Harness` section | Append Harness section only |
| Exists with Harness section | Skip CLAUDE.md; ensure docs/harness/ exists |

---

## Phase 2: Create — delegate to @harness-setup

**Goal:** Generate CLAUDE.md and docs/harness/ based on real project context.

Launch the **@harness-setup** agent with the project name, the action mode determined in Phase 1, and any user-provided rules.

Wait for the agent to complete before proceeding.

---

## Phase 3: Validate — delegate to @harness-reviewer

**Goal:** Confirm the freshly created harness is correct and complete.

Launch the **@harness-reviewer** agent. This is a fresh initialization — ask it to validate correctness and consistency, not staleness:

> Validate the harness for **$ARGUMENTS**. This is a fresh initialization — run your full audit but skip staleness checks. Report any issues and fix them.

Wait for the agent to confirm the harness is valid.

---

## Phase 4: Summary

**Goal:** Report what was created and what was learned.

```
Harness initialized for "$ARGUMENTS":

Inferred:
  - Identity: ...
  - Stack: ...
  - Phase: ...
  - Rules: ...

Created:
  - CLAUDE.md
  - docs/harness/index.md
  - docs/harness/troubleshooting/
  - docs/harness/decisions/
```
