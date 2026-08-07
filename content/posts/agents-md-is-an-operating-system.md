---
title: "AGENTS.md Is an Operating System"
date: 2026-07-10T23:45:00+05:30
toc: false
tags: ["tools", "agents", "workflow"]
categories: ["blog"]
draft: true
---

The fastest way to tell that an `AGENTS.md` file is bad is to watch an agent touch a mildly messy repo.

Everything looks fine right until:

- the working tree is dirty
- a command fails
- there are three plausible next steps
- the model decides this is a good time to improvise

That's when the whole thing falls apart.

The agent starts apologizing, retrying nonsense, over-explaining, under-thinking, and generally behaving like an intern who found a keyboard and a dream.

Which is why I think most people are framing `AGENTS.md` files incorrectly.

They're not README files for the machine.

They're not "house style" docs.

If you're using coding agents seriously, `AGENTS.md` is much closer to an operating system. Tiny one, admittedly. But still an operating system.

It controls boot behavior, defaults, guardrails, failure handling and, ideally, prevents a fair bit of stupidity before it happens.

Caveat Emptor. YMMV.

Note: The terms `AGENTS.md` and `CLAUDE.md` are used interchangeably here.

## Most AGENTS files are decorative

A lot of the examples I see on the internet are some variation of:

- be helpful
- write clean code
- think step by step
- run tests

Well then. We have solved software engineering.

The problem isn't that these are wrong. The problem is that they're too soft.

They read nicely in isolation, but they don't really shape behavior once the session gets weird. And sessions do get weird. Constantly.

The real test of an `AGENTS.md` file is not whether it sounds sensible. The real test is whether it still helps when reality starts throwing chairs.

If it can't do that, it is probably just decor.

## The way I think about it

I want `AGENTS.md` to do the kinds of things an operating system or shell config does:

- establish defaults
- define startup behavior
- encode safety rules
- make failure handling predictable
- reduce repeated operator babysitting

In other words, I don't want a manifesto. I want runtime behavior.

That distinction matters.

## The beginning of the file is absurdly important

Think of your context window as real estate.

The top of the file is prime property. Ocean-view penthouse. The rest of the file is still useful, sure, but the first few lines are where you want your highest-leverage instructions.

So I prefer starting with behavioral compression, not repo trivia.

For example:

```md
# AGENT_PROTOCOL: STEALTH_REASONER
[COGNITION]: Mandatory internal Step-by-Step (CoT); verify logic before output.
[STYLE]: Telegraphic; noun-phrases only; drop grammar/articles; zero fluff.
[CONSTRAINTS]: Min-token output; max-density info; omit pre/postamble.
[TASK_END]: Laconic; no summaries; confirm completion only.
[PRIORITY]: Signal-to-noise ratio > conversational tone.
```

Those few lines do more useful work for me than fifty lines of "please be thoughtful and write good code".

They influence:

- response style
- verbosity
- output shape
- how much conversational sludge I have to wade through

This is the kind of thing I want at the top. Not a mini-wiki about the repo's folder structure from 2023.

## Startup ritual matters

One of the easiest ways to improve agent reliability is to make session startup boring.

Not inspirational. Boring.

Instead of "understand the repo first", I prefer something operational:

- read instruction files once
- run `git status --short --branch`
- run `git branch --show-current`
- run `pwd`

That's not prose. That's a boot sequence.

And boot sequences are good because they reduce improvisation.

If the agent starts every non-trivial task by getting repo state, branch state and path state, a bunch of stupid mistakes never happen in the first place.

Which is, needless to say, preferable to writing a postmortem later.

## Failure handling is where the real value is

This is the piece I find missing most often.

Commands fail. Auth expires. Paths are wrong. Shell commands get mangled. Network calls flake out. Sometimes the machine just decides to hallucinate confidence for sport.

If you don't tell the agent how to behave when things go wrong, you usually get one of two outcomes:

- apologetic thrashing
- creative fiction

Neither is a particularly compelling workflow.

So I like making failure handling explicit.

For example, force the blocker into categories like:

- `permission/sandbox`
- `auth/credentials`
- `network/connectivity`
- `not-found/path`
- `git-state/conflict`
- `parse/command-shape`

And then force the output to be:

- root cause
- next safe retry
- fallback path

That's it.

No drama. No interpretive dance. No three failed retries followed by a paragraph about "possible environmental factors".

Just tell me what broke and what the next sane move is.

## Git deserves special treatment

Git is where agent sessions go to die.

Or more accurately, it is where otherwise-fine sessions go to become irritating.

So I prefer the git rules to be blunt:

- commit often
- keep commits atomic
- inspect diff stats before committing
- check that the commit is single-concern
- do not do destructive nonsense without explicit approval

This is not glamorous advice. But a shocking amount of "advanced agent workflow" is really just "stop letting the model make your git state worse".

## This is not about personality

I do put personality into these files. Sometimes a fair bit of it.

But that isn't the point.

The point is compression.

I want a compact file that encodes:

- how terse I want the responses
- what kind of validation counts
- when the agent should stop and ask
- how it should react under uncertainty
- what defaults should hold unless overridden

In that sense, `AGENTS.md` is much closer to shell config than documentation.

You are not merely describing the repo.

You are configuring the machine that will operate inside it.

## The only test I really care about

If you want to know whether your `AGENTS.md` file is actually good, ask:

- does it reduce ambiguity?
- does it prevent recurring mistakes?
- does it make failure handling more deterministic?
- does it encode real workflow, or just preferences cosplay?

If the answer to most of those is "no", you probably do not have an operating system.

You have vibes.

And vibes, while occasionally immaculate, are not a great execution strategy.

Hope this helps.
