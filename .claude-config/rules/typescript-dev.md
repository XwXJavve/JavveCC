---
name: typescript-dev
description: TypeScript toolchain and conventions
paths:
  - "**/*.{ts,tsx}"
---

Use **pnpm** (never npm/yarn).
Lint and format with **Biome** (`pnpm biome check --write .`).
Enable `strict: true` in tsconfig.
Never use `any` — use `unknown` with type guards.
Test with **vitest**.
