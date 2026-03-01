# AGENTS.md

Sanctum-specific operational rules.

## Build and deploy safety

- For deploy-affecting changes, run `scripts/predeploy-check.sh --offline` before commit.
- If Netlify CLI is linked, also run `scripts/predeploy-check.sh` before push.
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

## Algolia and search

- Local validation defaults to `ALGOLIA_DISABLED=true` in predeploy checks.
- Do not debug Algolia backend health before confirming a visible search UI exists in the site UX.
