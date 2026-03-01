#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/predeploy-check.sh [--offline] [--context <name>]

Options:
  --offline            Run Netlify build in offline mode
  --context <name>     Add build context to test (repeatable)
  -h, --help           Show this help

Defaults:
  contexts: production, deploy-preview

Notes:
- Sets ALGOLIA_DISABLED=true by default to skip local-only crawler plugin failure.
- Uses global 'netlify' CLI if available, otherwise falls back to 'npx netlify-cli@latest'.
EOF
}

OFFLINE=0
CONTEXTS=()

while [ "$#" -gt 0 ]; do
  case "$1" in
    --offline)
      OFFLINE=1
      shift
      ;;
    --context)
      if [ "$#" -lt 2 ]; then
        echo "error: --context requires a value" >&2
        exit 2
      fi
      CONTEXTS+=("$2")
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ "${#CONTEXTS[@]}" -eq 0 ]; then
  CONTEXTS=("production" "deploy-preview")
fi

if ! command -v hugo >/dev/null 2>&1; then
  echo "error: hugo not found in PATH" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 not found in PATH" >&2
  exit 1
fi

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT"

if [ ! -f "netlify.toml" ]; then
  echo "error: netlify.toml not found at repo root: $ROOT" >&2
  exit 1
fi

python3 - <<'PY'
import tomllib
from pathlib import Path
p = Path('netlify.toml')
try:
    tomllib.loads(p.read_text())
except Exception as e:
    raise SystemExit(f"error: invalid netlify.toml: {e}")
print("info: netlify.toml parse OK")
PY

if [ ! -d node_modules ]; then
  if ! command -v npm >/dev/null 2>&1; then
    echo "error: node_modules missing and npm not found" >&2
    exit 1
  fi
  echo "info: node_modules missing -> running npm install"
  npm install
fi

NETLIFY_CMD=()
if command -v netlify >/dev/null 2>&1; then
  NETLIFY_CMD=("netlify")
else
  if ! command -v npx >/dev/null 2>&1; then
    echo "error: neither 'netlify' nor 'npx' found in PATH" >&2
    exit 1
  fi
  NETLIFY_CMD=("npx" "--yes" "netlify-cli@latest")
fi

run_netlify() {
  "${NETLIFY_CMD[@]}" "$@"
}

IS_LINKED=0
if [ -n "${NETLIFY_SITE_ID:-}" ] || [ -f ".netlify/state.json" ]; then
  IS_LINKED=1
fi

if [ "$OFFLINE" -eq 0 ] && [ "$IS_LINKED" -ne 1 ]; then
  echo "error: Netlify project is not linked for online checks" >&2
  echo "hint: run 'netlify login' then 'netlify link', or rerun with --offline" >&2
  exit 1
fi

if [ "$IS_LINKED" -eq 1 ]; then
  echo "info: netlify project link detected"
else
  echo "info: running in offline mode without netlify link"
fi

export PATH="$PWD/node_modules/.bin:$PATH"
export ALGOLIA_DISABLED="${ALGOLIA_DISABLED:-true}"

echo "info: ALGOLIA_DISABLED=$ALGOLIA_DISABLED"

declare -a BUILD_ARGS
for ctx in "${CONTEXTS[@]}"; do
  echo "info: running netlify build for context: $ctx"
  BUILD_ARGS=(build --context "$ctx")
  if [ "$OFFLINE" -eq 1 ]; then
    BUILD_ARGS+=(--offline)
  fi
  run_netlify "${BUILD_ARGS[@]}"
done

echo "info: predeploy checks passed"
