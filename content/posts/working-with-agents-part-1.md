---
title: "Working With Agents - Part 1"
date: 2025-06-13T13:15:49+05:30
toc: false
tags: ["tools"]
categories: ["blog"]
---

Here are some of the agentic patterns, techniques and tools I use.

Caveat Emptor. YMMV.

Note: The terms `AGENTS.md` and `CLAUDE.md` are used interchangeably.


## Pro Tips

#### Text Expander

Use a **text expander** - anything that works for you and your env. I use [Espanso](https://espanso.org/) along with [Macspanso](https://github.com/jeffcaldwellca/macspanso). Add shorthand commands/patterns for your most used short prompts (and any other phrases) - saves an enormous amount of time!

Here're some of the things I found myself often telling my agents, and the shorthand expressions that I now use to inject them:

- `nn`:  What are the next steps?
- `md`:  Write to a new markdown file
- `comm`: Review the diff, group changes by feature/task, then git add and commit each group separately with clear conventional commit messages.

## Prompts and snippets for AGENTS.md

#### Fundamentals

```md
# AGENT_PROTOCOL: STEALTH_REASONER
[COGNITION]: Mandatory internal Step-by-Step (CoT); verify logic before output.
[STYLE]: Telegraphic; noun-phrases only; drop grammar/articles; zero fluff.
[CONSTRAINTS]: Min-token output; max-density info; omit pre/postamble.
[TASK_END]: Laconic; no summaries; confirm completion only.
[PRIORITY]: Signal-to-noise ratio > conversational tone.
```

Self Explanatory. These few short lines sit at the beginning of my root AGENTS.md file and they've made a world of difference!

#### Fresh Eyes

Telling the agent to review the plan/code with "**fresh eyes**" usually yield better results than a bare review request.

Here's what I use: `review the changes thoroughly with fresh eyes`

I have a text expansion expression for it (`rev`), so I use it indiscrimantly after any major plan/code change. The model infers the "changes" based on what we're working on.

#### Red/green TDD

While I've been adding the "Use TDD" instruction to my AGENTS.md files for a while now, changing it to `Use red/green TDD` , [as suggested](https://simonwillison.net/guides/agentic-engineering-patterns/red-green-tdd/) by the brilliant Simon Willison, enforces the correct way to implement the principle, yielding better results
