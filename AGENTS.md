# AGENTS.md

Sanctum-specific operational rules.

## Scope

- Applies only to `sanctum` local build/deploy workflow.
- Root rules from `~/.agents/AGENTS.md` and global rules from `homebase/AGENTS.md` also apply.

## Build and deploy safety

- For deploy-affecting edits, run `scripts/preflight.sh --build` before push.
- Run `scripts/predeploy-check.sh` before pushing deploy-affecting changes.
- Use `scripts/predeploy-check.sh --online` only when Netlify project is linked and online parity is required.
- Do not push deploy-affecting changes until required checks pass.

## Hugo and config consistency

- Keep all `HUGO_VERSION` values in `netlify.toml` synchronized.
- After Hugo/config changes, verify with `hugo --gc --minify`.
- Validate `netlify.toml` syntax after edits.

## Theme/layout troubleshooting

- `themes/hello-friend-ng` is a git submodule; initialize/update it before layout diagnosis.
- Check local overrides under `layouts/` before editing theme files.

## Sass policy

- Current production path uses `libsass` in `layouts/partials/head.html`.
- Do not switch to `dartsass` unless Netlify parity is explicitly verified.

## Search status

- Algolia crawler plugin is disabled.
- Search UX is parked in backlog.
- Do not spend time on search implementation until explicitly resumed.
