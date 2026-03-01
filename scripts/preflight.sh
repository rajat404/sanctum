#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/preflight.sh [--fix] [--fetch] [--build]

Options:
  --fix       Auto-fix safe issues (init submodules, install node deps)
  --fetch     Run `git fetch origin` and report upstream ahead/behind
  --build     Run Hugo smoke build at end
  -h, --help  Show this help

Checks:
- git repo + branch + HEAD
- working tree cleanliness
- submodule initialization/status
- required tools (hugo, python3)
- netlify.toml parse
- node_modules availability
EOF
}

FIX=0
RUN_FETCH=0
RUN_BUILD=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --fix)
      FIX=1
      shift
      ;;
    --fetch)
      RUN_FETCH=1
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
echo "info: branch -> $(git rev-parse --abbrev-ref HEAD)"
echo "info: head -> $(git rev-parse --short HEAD)"

STATUS="$(git status --short)"
if [ -n "$STATUS" ]; then
  echo "warn: working tree is dirty"
  echo "$STATUS"
else
  echo "info: working tree clean"
fi

if [ "$RUN_FETCH" -eq 1 ]; then
  if git remote get-url origin >/dev/null 2>&1; then
    echo "info: fetching origin"
    git fetch --quiet origin || echo "warn: git fetch origin failed"
  else
    echo "warn: no origin remote configured; skipping fetch"
  fi

  if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    COUNTS="$(git rev-list --left-right --count HEAD...@{u})"
    read -r AHEAD BEHIND <<< "$COUNTS"
    echo "info: upstream divergence -> ahead=$AHEAD behind=$BEHIND"
    if [ "$BEHIND" -gt 0 ]; then
      echo "warn: local branch behind upstream"
    fi
  else
    echo "warn: no upstream tracking branch configured"
  fi
fi

SUB_OUT="$(git submodule status --recursive || true)"
if [ -n "$SUB_OUT" ]; then
  echo "info: submodule status"
  echo "$SUB_OUT"
fi

if echo "$SUB_OUT" | grep -qE '^-'; then
  if [ "$FIX" -eq 1 ]; then
    echo "info: initializing submodules"
    git submodule update --init --recursive
  else
    echo "error: uninitialized submodules found (run with --fix)" >&2
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
    echo "warn: node_modules missing (run with --fix)"
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
