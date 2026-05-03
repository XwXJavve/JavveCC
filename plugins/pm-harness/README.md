# pm-harness

Project memory harness plugin for Claude Code. Maintain cross-session knowledge via **two-layer architecture**: `CLAUDE.md` (per-session essentials, loaded every time) and `docs/harness/` (on-demand troubleshooting and decisions).

## Layer principle

| Layer | File | Purpose | Example content |
|-------|------|---------|----------------|
| Entry point | `CLAUDE.md` | Loaded every session | Tech stack, conventions, **pointer to docs/harness/** |
| Catalog | `docs/harness/index.md` | Read when searching | Index with "when to check" guidance |
| Content | `docs/harness/troubleshooting/` | Read when hitting a bug | Root cause + fix for specific issues |
| Content | `docs/harness/decisions/` | Read when revisiting a choice | Rationale + trade-offs |

## Components

| Component | Description |
|-----------|-------------|
| `/harness-init` | Initialize both `CLAUDE.md` (concise entry point) and `docs/harness/` (detailed records) |
| `harness-update` (skill) | Scan conversation, classify knowledge by layer, write to correct destination |
| `@harness-reviewer` (agent) | Audit both `CLAUDE.md` boundary health and `docs/harness/` content staleness |
| Stop hook | Prompts to save learnings at end of session when `docs/harness/` exists |

## Usage

```bash
/harness-init <project-name>
```

During work: say "save learnings" to capture session knowledge. The skill will ask: "Should this go in CLAUDE.md (every session) or docs/harness/ (on demand)?"

At session end: respond to the hook prompt or run `@harness-reviewer` periodically to keep things tidy.
