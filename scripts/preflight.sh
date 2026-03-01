#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/preflight.sh [--fix] [--skip-fetch] [--build]

Options:
  --fix         Auto-fix safe issues (init submodules, install node deps)
  --skip-fetch  Skip `git fetch origin` freshness check
  --build       Run Hugo smoke build at end
  -h, --help    Show this help

Checks:
- git repo + branch + HEAD
- working tree cleanliness
- upstream ahead/behind (if configured)
- submodule initialization/status
- required tools (hugo, python3, netlify or npx)
- netlify.toml parse
- node_modules availability
EOF
}

FIX=0
SKIP_FETCH=0
RUN_BUILD=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --fix)
      FIX=1
      shift
      ;;
    --skip-fetch)
      SKIP_FETCH=1
      shift
      ;;
    --build)
      RUN_BUILD=1
      shift
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

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$ROOT" ]; then
  echo "error: not inside a git repository" >&2
  exit 1
fi
cd "$ROOT"

echo "info: repo -> $ROOT"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
HEAD_SHA="$(git rev-parse --short HEAD)"
echo "info: branch -> $BRANCH"
echo "info: head -> $HEAD_SHA"

STATUS="$(git status --short)"
if [ -n "$STATUS" ]; then
  echo "warn: working tree is dirty"
  echo "$STATUS"
else
  echo "info: working tree clean"
fi

if [ "$SKIP_FETCH" -eq 0 ]; then
  if git remote get-url origin >/dev/null 2>&1; then
    echo "info: fetching origin for freshness check"
    git fetch --quiet origin || echo "warn: git fetch origin failed"
  else
    echo "warn: no origin remote configured; skipping freshness fetch"
  fi
fi

if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
  COUNTS="$(git rev-list --left-right --count HEAD...@{u})"
  BEHIND="${COUNTS%% *}"
  AHEAD="${COUNTS##* }"
  echo "info: upstream divergence -> ahead=$AHEAD behind=$BEHIND"
  if [ "$BEHIND" -gt 0 ]; then
    echo "warn: local branch is behind upstream; pull/rebase before major changes"
  fi
else
  echo "warn: no upstream tracking branch configured"
fi

SUB_OUT="$(git submodule status --recursive || true)"
if [ -n "$SUB_OUT" ]; then
  echo "info: submodule status"
  echo "$SUB_OUT"
fi

if echo "$SUB_OUT" | grep -qE '^-'; then
  if [ "$FIX" -eq 1 ]; then
    echo "info: fixing uninitialized submodules"
    git submodule update --init --recursive
    SUB_OUT="$(git submodule status --recursive || true)"
  else
    echo "error: uninitialized submodules found (run with --fix or run git submodule update --init --recursive)" >&2
    exit 1
  fi
fi

if ! command -v hugo >/dev/null 2>&1; then
  echo "error: hugo not found in PATH" >&2
  exit 1
fi
if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 not found in PATH" >&2
  exit 1
fi
if ! command -v netlify >/dev/null 2>&1 && ! command -v npx >/dev/null 2>&1; then
  echo "error: neither netlify nor npx found in PATH" >&2
  exit 1
fi

echo "info: tool checks passed"

if [ ! -f netlify.toml ]; then
  echo "error: netlify.toml not found" >&2
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
  if [ "$FIX" -eq 1 ]; then
    if ! command -v npm >/dev/null 2>&1; then
      echo "error: npm not found (required to install node_modules)" >&2
      exit 1
    fi
    echo "info: installing node dependencies"
    npm install
  else
    echo "warn: node_modules missing (run with --fix to install)"
  fi
else
  echo "info: node_modules present"
fi

if [ "$RUN_BUILD" -eq 1 ]; then
  export PATH="$PWD/node_modules/.bin:$PATH"
  echo "info: running hugo smoke build"
  hugo --gc --minify
fi

echo "info: preflight checks completed"
