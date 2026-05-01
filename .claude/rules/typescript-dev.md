---
name: typescript-dev
description: TypeScript development rules
paths:
  - "**/*.{ts,tsx}"
---

# TypeScript Development Rules

## Package Management

- Use `pnpm` as the package manager (not `npm` or `yarn`)
- `pnpm add <pkg>` — add dependency
- `pnpm add -D <pkg>` — add dev dependency
- Prefer `pnpm dlx` over `npx` for one-off commands

## Code Quality

- Enable `strict: true` in `tsconfig.json`
- Use `Biome` for linting and formatting (`pnpm biome check --write .`)
- Prefer `const` over `let`, and `as const` for literal types
- Use `interface` for public API shapes, `type` for unions/computed types
- No `any` — use `unknown` and narrow with type guards

## Testing

- Use `vitest` for unit and integration tests
- Name test files: `<name>.test.ts` or `<name>.test.tsx`
- Place tests co-located with source files (`src/**/*.test.ts`)
- Use `describe` / `it` blocks, avoid raw `test()`

## Project Structure

```
src/          # source code
  index.ts    # public API barrel
  types/      # shared type definitions
  utils/      # utility functions
  components/ # (if React)
tests/        # optional: only if co-location isn't enough
```
