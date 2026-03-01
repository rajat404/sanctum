# Sanctum

[![Netlify Status](https://api.netlify.com/api/v1/badges/7f38e56f-08af-41fd-9685-7ed1badec966/deploy-status)](https://app.netlify.com/sites/rajat404/deploys)


Source for my website running at https://rajat404.com

Version Change
- 1 Mar 2026: hugo v0.157.0

Local build
- `npm install`
- `PATH="$PWD/node_modules/.bin:$PATH" hugo --gc --minify`

Preflight
- `scripts/preflight.sh`
- `scripts/preflight.sh --fix --build` (auto-fix submodules/deps + smoke build)

Predeploy check
- `scripts/predeploy-check.sh --offline`
- `scripts/predeploy-check.sh` (requires Netlify link/auth)

TODO:
- feedback fish
- posthog
- algolia
- change `cd home` to `home`
