---
name: harness-update
description: Review current conversation, classify knowledge into CLAUDE.md (per-session essentials) or docs/harness/ (on-demand records), then write. Relevant at end of sessions, after fixing bugs, when new patterns emerge, or when asked to save learnings.
argument-hint: "[optional-focus-area]"
---

Review the current conversation and capture actionable knowledge. Focus on $ARGUMENTS if provided (e.g. "troubleshooting", "decisions").

**Prerequisite:** `docs/harness/` must exist. If not, suggest running `/harness-init` first.

Before starting, create a TodoWrite list to track progress through the steps below.

If a candidate's details are unclear (e.g. "fixed a bug" with no root cause), ask the user before guessing — don't write a vague entry.

## Step 1: Identify candidates

Use TodoWrite to mark this step in progress.

Scan the conversation for:

- **Troubleshooting wins** — solved bugs with root cause + fix
- **Design decisions** — what was chosen, why, trade-offs
- **Setup gotchas** — environment issues, version conflicts, config surprises
- **Emerging conventions** — patterns that appeared repeatedly (naming, structure, workflow)
- **Behavioral rules** — project-specific instructions that Claude should follow every session

Skip trivial fixes (typos, formatting) and speculation with no outcome.

## Step 2: Classify — CLAUDE.md or docs/harness/

This is the critical gate. Each candidate goes to one bucket:

| Bucket | Destination | Include if... | When to read |
|--------|-------------|---------------|-------------|
| **CLAUDE.md** | root `CLAUDE.md` | Project-wide convention, behavioral rule, invariant that affects *every* interaction | Every session (always loaded) |
| **docs/harness/** | `docs/harness/troubleshooting/` or `docs/harness/decisions/` | One-off bug fix, specific design decision, setup gotcha with narrow relevance | Only when a "when to check" trigger fires |

**Boundary tests:**

To decide "CLAUDE.md vs docs/harness/", ask:

> "If Claude doesn't know this at the start of a session, will it make a mistake?"

- Yes → **CLAUDE.md** (e.g. "we always use pnpm, not npm")
- No → **docs/harness/** (e.g. "JWT token refresh bug in auth middleware — fix was to check expiry before decode")

**Promotion rule:** If a docs/harness/ entry keeps being relevant across sessions, it should be promoted to CLAUDE.md. Flag repeated hits to the user.

**Demotion rule:** If CLAUDE.md grows beyond ~100 lines, some content should be demoted to docs/harness/. Flag this to the user.

## Step 3: Quality gate (applies to both buckets)

Before writing, each candidate must pass:

| Gate | Question |
|------|----------|
| **Actionable** | Would a future developer know exactly what to do or avoid? |
| **Specific** | Does it reference files, commands, error messages, or versions? |
| **Concise** | Could this be half as long without losing meaning? |

If a candidate fails any gate, refine it or skip it.

## Step 4: Write to files

Mark the TodoWrite step in progress before writing, and complete it when done.

### For CLAUDE.md candidates

Read current `CLAUDE.md`. If the relevant section already exists, add the rule there. If not, add it. Keep each entry to 1-2 lines.

Format:

```markdown
- [Rule]: [one-line actionable instruction]
```

Ask the user to confirm before modifying `CLAUDE.md`.

### For docs/harness/ candidates

#### Troubleshooting entries

Write each as a standalone file in `docs/harness/troubleshooting/`. Use a slug filename (e.g. `eslint-flat-config-breaks.md`):

```markdown
# [One-line summary]

- **Symptom:** [what you saw — error message, behavior]
- **Cause:** [root cause]
- **Fix:** [what resolved it]
- **Context:** [when / where this happened — specific file, version, config]
```

#### Decision entries

Write each as a standalone file in `docs/harness/decisions/`:

```markdown
# [One-line summary]

- **Decision:** [what was chosen]
- **Alternatives considered:** [what else was on the table]
- **Rationale:** [why this choice]
- **Trade-offs:** [what we give up]
```

## Step 5: Update index.md (for docs/harness/ entries only)

Mark the TodoWrite step in progress before updating, and complete it when done.

For each new entry added, update the corresponding section in `docs/harness/index.md`. Use the format:

```markdown
- [entry-title](troubleshooting/filename.md) — [One-line summary]
  - **When to check:** [what triggers reading this]
```

The "When to check" field is the most important part — it tells Claude when to consult this document. Be specific:

| Bad | Good |
|-----|------|
| "When working on auth" | "When you see 'JWT expired' errors in auth middleware" |
| "About the database" | "When writing a migration that touches the users table" |

## Step 6: Confirm

Mark the TodoWrite step complete for overall task.

```
Captured:
  [CLAUDE.md] — <rule> (user confirmed)
  docs/harness/troubleshooting/<slug>.md: <title>
  docs/harness/decisions/<slug>.md: <title>

Index updated: docs/harness/index.md (+N entries)
Discarded: [candidates that failed quality gate]
Promotion suggestions: [entries that may need to move to CLAUDE.md]
Demotion suggestions: [CLAUDE.md sections that could move to docs/harness/]
```
