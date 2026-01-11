$ErrorActionPreference = "Stop"

# Prints a deterministic repo tree while excluding noisy/generated directories.
# This is used for verification output in this project.

$excluded = @(
  ".git",
  ".venv",
  "venv",
  "__pycache__",
  ".mypy_cache",
  ".pytest_cache",
  ".ruff_cache",
  ".ipynb_checkpoints",
  "data\raw",
  "data\interim",
  "data\processed",
  "logs",
  "dags",
  "plugins"
)

$excludeRegex = ($excluded | ForEach-Object { [regex]::Escape($_) }) -join "|"

Get-ChildItem -Recurse -Force |
  Where-Object {
    $rel = $_.FullName.Substring((Get-Location).Path.Length).TrimStart("\")
    $rel -ne "" -and ($rel -notmatch $excludeRegex)
  } |
  ForEach-Object {
    $_.FullName.Substring((Get-Location).Path.Length).TrimStart("\")
  } |
  Sort-Object |
  ForEach-Object { $_ }
