# Decision log

## 0001 - Use filtered project tree output for verification

Decision:

- Use a repository-local PowerShell script to print a filtered project tree for verification outputs.

Alternatives considered:

- Use `tree /f` directly.
- Use `dir /s` and manually scan.
- Use a third-party tree utility.

Rationale:

- `tree /f` is not useful when the working directory contains virtualenv or Airflow runtime artifacts.
- A filtered script produces deterministic, reviewable output and reduces noise.

Trade-offs:

- Requires PowerShell for the verification command on Windows.
- Must maintain the exclusion list as we add new generated folders.

## 0002 - Commit poetry.lock for reproducible builds

Decision:

- Commit poetry.lock to version control.

Alternatives considered:

- Do not commit poetry.lock and rely on pyproject.toml constraints only.
- Use a different dependency manager (pip-tools, uv).

Rationale:

- Lockfiles provide deterministic dependency resolution across machines and CI/CD.
- This project has a production-quality requirement, so reproducibility is non-negotiable.

Trade-offs:

- Lockfile updates must be reviewed and managed intentionally.
- Minor friction when updating dependencies, offset by reproducibility benefits.
