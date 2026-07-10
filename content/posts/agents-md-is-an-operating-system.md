---
title: "AGENTS.md Is an Operating System"
date: 2026-07-10T23:45:00+05:30
toc: false
tags: ["tools", "agents", "workflow"]
categories: ["blog"]
draft: true
---

Most people seem to treat `AGENTS.md` like a prettier README for the machines.

I think that's underselling the thing.

If you're using coding agents seriously, `AGENTS.md` is less of a style guide and more of an operating system. Tiny one, admittedly. But still an operating system.

It decides what gets loaded first, what the runtime defaults are, what kind of failures are acceptable, what shape the outputs should have and, perhaps most importantly, what kinds of stupidity should be prevented before they happen.

Caveat Emptor. YMMV.

Note: The terms `AGENTS.md` and `CLAUDE.md` are used interchangeably here.

## Most AGENTS files are too soft

A lot of the examples floating around on the internet read like this:

- be helpful
- write clean code
- think step by step
- run tests

Well then. Groundbreaking stuff.

The issue isn't that these are wrong. The issue is that they're too vague to shape behavior in any meaningful way once the session gets messy.

The real test of an `AGENTS.md` file is not whether it reads well in isolation. The real test is whether it still helps when:

- the repo is dirty
- the command just failed
- there are three plausible next steps
- the model is about to improvise some nonsense

That's where a weak `AGENTS.md` file quietly evaporates.

## What I want from it instead

My root `AGENTS.md` files tend to do four things.

### Set the tone early

The beginning matters more than people think.

LLMs are basically glorified autocomplete engines with delusions of grandeur. They infer behavior from the context they're given, and the earliest instructions tend to have outsized influence.

So the first few lines in my files are usually not about repo trivia. They define the behavioral contract.

For example:

```md
# AGENT_PROTOCOL: STEALTH_REASONER
[COGNITION]: Mandatory internal Step-by-Step (CoT); verify logic before output.
[STYLE]: Telegraphic; noun-phrases only; drop grammar/articles; zero fluff.
[CONSTRAINTS]: Min-token output; max-density info; omit pre/postamble.
[TASK_END]: Laconic; no summaries; confirm completion only.
[PRIORITY]: Signal-to-noise ratio > conversational tone.
```

Those few lines do more useful work than fifty lines of generic "please be thoughtful".

### Define startup ritual

I want the session to begin predictably.

So instead of saying "understand the repo first", I prefer something operational:

- read root instruction files once
- run `git status --short --branch`
- run `git branch --show-current`
- run `pwd`

That's not prose. That's muscle memory.

And muscle memory is exactly what you want when the model is hopping across repos and sessions all day.

### Define failure handling

This is the part I see missing most often.

Commands fail. Paths are wrong. Auth expires. Network flakes. Shell incantations go sideways.

If you don't define how the agent should react, you'll usually get one of two failure modes:

- apologetic thrashing
- creative fiction

Neither is particularly useful.

So I prefer explicit blocker classification. Something like:

- `permission/sandbox`
- `auth/credentials`
- `network/connectivity`
- `not-found/path`
- `git-state/conflict`
- `parse/command-shape`

And then force the response into a simple structure:

- root cause
- next safe retry
- fallback path

That's it.

No interpretive dance.

### Encode version-control behavior

Git is where a lot of agent sessions go to die.

So I like the rules to be blunt:

- commit often
- keep commits atomic
- inspect diff stats before commit
- confirm single concern
- don't do destructive nonsense unless explicitly asked

This is not glamorous. But a huge chunk of "good agent workflow" is really just "stop making git state worse".

## The point isn't personality

Ironically, I do put a fair bit of personality into these files.

But that is not the point.

The point is compression.

I want a compact set of instructions that encodes how I like to work:

- how much verbosity I want
- what counts as sufficient validation
- when to stop and ask
- how to behave when the environment gets weird

In that sense, `AGENTS.md` is much closer to shell config than documentation.

You are not just explaining the repo. You are configuring the machine.

## A decent test

If you want to know whether your `AGENTS.md` file is any good, ask yourself:

- does it reduce ambiguity?
- does it prevent recurring mistakes?
- does it make failure handling more deterministic?
- does it encode actual workflow, or just preferences cosplay?

If the answer to most of those is "no", you probably don't have an operating system yet.

You have vibes.

And vibes, while occasionally immaculate, are not a great execution strategy.

Hope this helps.
