---
title: "Don't Patch Your Rules Mid-Session"
date: 2026-07-10T23:48:00+05:30
toc: false
tags: ["tools", "agents", "workflow"]
categories: ["blog"]
draft: true
---

One of the easiest ways to ruin an agent workflow is to keep patching your rules in the middle of sessions.

Something weird happens.
You get annoyed.
You jam a new instruction into `AGENTS.md`.

Problem solved, right?

Perhaps.

More often, you've just enshrined a local irritation into permanent policy.

## The temptation

I get it.

When an agent repeats some particularly stupid behavior, the urge to add a defensive line to your instructions is very strong.

Things like:

- always do X
- never do Y
- ask before Z
- format responses like this from now on forever

Sometimes that is exactly the right move.

But if you do it impulsively, the instruction file turns into a junk drawer of historical grievances.

And junk drawers, while useful in homes, are not ideal operating systems.

## Local fix vs durable learning

The distinction I care about is simple:

- was this a real recurring pattern?
- or was this just an annoying moment?

If it is recurring, costly, or non-obvious, it may deserve promotion into durable guidance.

If not, I would much rather capture it separately as a learning artifact and let it age for a bit.

This slows things down slightly.

Good.

The friction is the feature.

## Why append-only artifacts help

Instead of mutating policy immediately, I like writing down the learning first.

That forces a few useful questions:

- what exactly happened?
- who is this guidance for?
- what future behavior would change because of it?
- what is the evidence?
- does this belong in AGENTS, a skill, a prompt, memory, or nowhere?

The "or nowhere" option is doing a lot of work here.

Not every observation deserves immortality.

## This also keeps your AGENTS files cleaner

Instruction files should carry high-leverage, repeated truths.

They should not become:

- a session diary
- a patch log
- a museum of every time a model annoyed you

If you skip the intermediate learning step, all of that muck gets shoved straight into policy.

The file grows.
The signal drops.
The contradictions multiply.
And a few weeks later you have an elaborate constitution whose main achievement is making future sessions slightly more confused.

Majestic, really.

## My current bar for durable guidance

I generally want at least one of these before something graduates into permanent rules:

- repeated pattern
- expensive mistake
- non-obvious lesson
- persistent ambiguity
- tool drift that will likely recur

If I cannot explain why the learning changes future behavior, it probably does not belong in a permanent file yet.

## There's another subtle benefit

Writing the learning separately also makes cleanup easier.

You can later decide:

- this should become an AGENTS rule
- this should update an existing skill
- this belongs in a prompt
- this was a one-off and can die quietly

That is a much saner workflow than editing your global instructions every time the machine sneezes funny.

## In short

Don't let momentary frustration write long-term policy.

Capture the lesson.
Let it breathe.
Promote it only if it actually deserves the real estate.

Because once your rule files start behaving like a live incident channel, the machines aren't the only ones losing the plot.

Hope this helps.
