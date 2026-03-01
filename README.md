# Sanctum

[![Netlify Status](https://api.netlify.com/api/v1/badges/7f38e56f-08af-41fd-9685-7ed1badec966/deploy-status)](https://app.netlify.com/sites/rajat404/deploys)

Source for https://rajat404.com

Version change
- 1 Mar 2026: Hugo v0.157.0

Local build
- `npm install`
- `PATH="$PWD/node_modules/.bin:$PATH" hugo --gc --minify`

Preflight
- `scripts/preflight.sh`
- `scripts/preflight.sh --fix --build`
- `scripts/preflight.sh --fetch --build` (when freshness check is needed)

Predeploy check
- `scripts/predeploy-check.sh` (offline default)
- `scripts/predeploy-check.sh --online` (requires Netlify link/auth)

CI
- GitHub Actions runs `scripts/preflight.sh --build` on push/PR.

TODO
- feedback fish
- posthog
- change `cd home` to `home`
