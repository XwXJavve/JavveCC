---
name: python-dev
description: Python development rules
paths:
  - "**/*.py"
---

# Python Development Rules

## Package Management (uv)

- Use `uv` for all package operations (never `pip` or `poetry`)
- `uv add <pkg>` — add a dependency
- `uv add --dev <pkg>` — add a dev dependency
- `uv sync` — sync environment with lockfile
- `uv run <script.py>` — run scripts in the managed venv
- `uv lock` — update lockfile after dependency changes
- Prefer `pyproject.toml` over `setup.py` or `setup.cfg`

## Code Quality

- Format and lint with `ruff` via `uv run ruff check . && uv run ruff format .`
- Type-check with `pyright` via `uv run pyright`
- Use type hints on all public functions and methods

## Testing

- Use `pytest` via `uv run pytest`
- Place tests in a top-level `tests/` directory, mirroring source structure
- Test files: `test_<module>.py`
- Use `tmp_path` for temp files, `httpx` for HTTP mocking

## Project Structure

```
pyproject.toml      # project config, deps, tool settings
src/<package>/      # source code
tests/              # tests
```
