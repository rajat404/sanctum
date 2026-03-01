# AGENTS.md

Sanctum-specific operational rules.

## Build and deploy safety

- CI runs `scripts/preflight.sh --skip-fetch --build` on push/PR; keep that path green.

- Before major diagnosis, upgrades, or deploy-affecting edits, run `scripts/preflight.sh`.
- For deploy-affecting changes, run `scripts/predeploy-check.sh --offline` before commit.
- If Netlify CLI is linked, run `scripts/predeploy-check.sh --online` before push.
- Do not push deploy-affecting changes until the relevant predeploy checks pass.

## Hugo and config consistency

- Keep `HUGO_VERSION` values in `netlify.toml` synchronized when upgrading Hugo.
- After Hugo upgrades, verify with `hugo --gc --minify`.
- Validate `netlify.toml` syntax after edits; avoid nested quote mistakes in command strings.

## Theme and layout troubleshooting

- `themes/hello-friend-ng` is a git submodule; update/init submodule before diagnosing missing layout/template issues.
- Check local layout overrides in `layouts/` before modifying theme files.

## Sass pipeline policy

- Current stable path uses `libsass` in `layouts/partials/head.html` for Netlify compatibility.
- Do not switch to `dartsass` in production workflow unless Netlify build parity is explicitly verified.

## Search status

- Algolia Netlify crawler plugin is currently disabled in `netlify.toml`.
- Search UX work is parked in backlog.
- Do not spend time on Algolia integration until search UX work is resumed.
