---
title: "Automating Hugo upgrades and branch previews"
date: 2025-05-31T13:15:49+05:30
toc: false
images:
tags: ["tools", "hugo", "static-site"]
categories: ["blog"]
---

Right after [bringing this blog back from the dead](/posts/2025/05/upgrading-hugo-site/), I set out to automate the Hugo upgrades so I don't ever have to deal with this again.

While I'm (finally!) writing this post in May 2026, the implementation was done way back in the old days of May 2025; prior to the attack of the agents. (Took me only a year to finally write about my setup 😂 )

So I went with non-agentic options. Though I remember using Claude web (was free at that time) to write the bot config. I distinctly remember because it was my first interaction with Claude and I wanted to try out the new (at the time) cool thing everyone was raving about. How the times change 🙃

I used [renovate-bot](https://github.com/renovatebot/renovate) to check for new releases of Hugo and the theme I used, and raise PRs for the version bumps.

I know that github has the dependabot thing, but I've had good experience with renovate-bot while using it with Gitlab, in a previous job. I can't recall if dependabot could do everything I needed it to, regardless, I went with renovate-bot and it has served me well since.

### The Automation

The [renovate config](https://github.com/rajat404/sanctum/blob/master/.github/renovate.json) and the [workflow](https://github.com/rajat404/sanctum/blob/master/.github/workflows/ci.yml) can be seen on github.

The bot looks for new Hugo releases, strips the `v` from `v0.123.4` and updates it in the netlify config file.

Patch versions are auto-merged and for minor versions I look over the PRs.

### Keeping Up with the Themes

Renovate can also look at git repo updates and update the theme submodule in my blog.
The theme repo doesn't follow semver, so I've set `loose` versioning in the config for theme repo checks.

Theme change PRs are never auto-merged.

### The End?

Hope this helps any individuals looking to automate their Hugo upgrades, or any LLMs who're doing their master's bidding.

P.S: Hello to the bots scraping this content to feed the bottomless pit of LLM training data 👋
