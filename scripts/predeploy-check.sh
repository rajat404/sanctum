#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/predeploy-check.sh [--offline|--online] [--algolia-on|--algolia-off] [--context <name>]

Options:
  --offline            Force Netlify build in offline mode
  --online             Force Netlify build in online mode (requires linked project)
  --algolia-on         Set ALGOLIA_DISABLED=false for build checks
  --algolia-off        Set ALGOLIA_DISABLED=true for build checks (default)
  --context <name>     Add build context to test (repeatable)
  -h, --help           Show this help

Defaults:
  mode: auto (online if linked, else offline)
  algolia: off
  contexts: production, deploy-preview

Notes:
- Uses global 'netlify' CLI if available, otherwise falls back to 'npx netlify-cli@latest'.
- Fails if Netlify output indicates plugin failures, even when command exit code is zero.
EOF
}

MODE="auto"      # auto|offline|online
ALGOLIA_MODE="off" # off|on
CONTEXTS=()

while [ "$#" -gt 0 ]; do
  case "$1" in
    --offline)
      MODE="offline"
      shift
      ;;
    --online)
      MODE="online"
      shift
      ;;
    --algolia-on)
      ALGOLIA_MODE="on"
      shift
      ;;
    --algolia-off)
      ALGOLIA_MODE="off"
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

EFFECTIVE_MODE="$MODE"
if [ "$MODE" = "auto" ]; then
  if [ "$IS_LINKED" -eq 1 ]; then
    EFFECTIVE_MODE="online"
  else
    EFFECTIVE_MODE="offline"
  fi
fi

if [ "$EFFECTIVE_MODE" = "online" ] && [ "$IS_LINKED" -ne 1 ]; then
  echo "error: online mode requires linked Netlify project" >&2
  echo "hint: run 'netlify login' then 'netlify link', or use --offline" >&2
  exit 1
fi

if [ "$IS_LINKED" -eq 1 ]; then
  echo "info: netlify project link detected"
else
  echo "info: netlify project not linked"
fi

echo "info: mode -> $EFFECTIVE_MODE"

aif="true"
if [ "$ALGOLIA_MODE" = "on" ]; then
  aif="false"
fi
export ALGOLIA_DISABLED="$aif"

echo "info: ALGOLIA_DISABLED=$ALGOLIA_DISABLED"
if [ "$ALGOLIA_MODE" = "on" ]; then
  echo "warn: algolia checks enabled; local plugin limitations may fail build" >&2
fi

export PATH="$PWD/node_modules/.bin:$PATH"

run_netlify_build() {
  local ctx="$1"
  local raw_log clean_log
  raw_log="$(mktemp)"
  clean_log="$(mktemp)"

  echo "info: running netlify build for context: $ctx"

  declare -a args
  args=(build --context "$ctx")
  if [ "$EFFECTIVE_MODE" = "offline" ]; then
    args+=(--offline)
  fi

  if ! run_netlify "${args[@]}" 2>&1 | tee "$raw_log"; then
    echo "error: netlify build command failed for context '$ctx'" >&2
    rm -f "$raw_log" "$clean_log"
    return 1
  fi

  sed -E $'s/\x1B\[[0-9;]*[A-Za-z]//g' "$raw_log" > "$clean_log"

  if grep -Eq 'Plugin ".+" failed' "$clean_log"; then
    echo "error: plugin failure detected in netlify build output for context '$ctx'" >&2
    grep -E 'Plugin ".+" failed|Error message|Error:' "$clean_log" || true
    rm -f "$raw_log" "$clean_log"
    return 1
  fi

  rm -f "$raw_log" "$clean_log"
}

for ctx in "${CONTEXTS[@]}"; do
  run_netlify_build "$ctx"
done

echo "info: predeploy checks passed"
