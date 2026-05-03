---
name: python-dev
description: Python toolchain and conventions
paths:
  - "**/*.py"
---

Use **uv** for all package operations (never pip/poetry).
Lint and format with **ruff** (`uv run ruff check . && uv run ruff format .`).
Type-check with **pyright** (`uv run pyright`).
Test with **pytest** (`uv run pytest`).
