---
title: "Mine Your Rejected Plans"
date: 2026-07-10T23:47:00+05:30
toc: false
tags: ["tools", "agents", "workflow"]
categories: ["blog"]
draft: true
---

Most people seem to pay attention only to the plans that worked.

Understandable. Success has better PR.

But if you're trying to improve how you work with agents, the more interesting dataset is usually the pile of plans that got denied, rejected, abandoned, or quietly rewritten after somebody noticed they were nonsense.

That pile is gold.

Messy gold, sure. But gold nonetheless.

## The denied plan is a better teacher

When a plan gets rejected, something useful has happened:

- the scope was unclear
- a constraint was missing
- a dependency was misunderstood
- the task was sequenced badly
- the writing was vague
- or the whole thing was just optimistic fan fiction

All of those are valuable signals.

If you only keep the final cleaned-up version, you lose the trail of how the failure happened.

And that trail is usually the part worth studying.

## I don't mean "do a quick retro"

What I mean is: treat rejected plans like a real corpus.

Collect them.
Tag them.
Look for recurring failure shapes.

Because after a while, patterns emerge.

For example:

- scope gaps show up again and again
- edge cases are consistently ignored
- plans assume a repo shape that does not actually exist
- the agent proposes clean phases while quietly skipping the hardest dependency

Once you've seen the same failure mode ten times, it stops being an isolated accident and starts looking a lot like workflow debt.

## This changes how you improve prompts

Most prompt tweaking is cargo cult territory.

Something worked once, so people add three more lines to a system prompt and hope the gods are pleased.

I prefer a slightly less ceremonial approach.

If I can see why plans are failing in aggregate, I can decide whether the fix belongs in:

- the task framing
- the instruction files
- the repo docs
- the skill
- the planning rubric
- or nowhere at all

That last one is important too.

Not every denial deserves a permanent rule. Some plans are bad because the day was cursed, Mercury was in retrograde, or the repo was just unusually weird.

## Things worth looking for

When reading through rejected plans, I care about a few questions:

### What kind of miss was this?

Was it:

- missing context?
- bad sequencing?
- weak terminology?
- hand-wavy validation?
- over-broad scope?

Different misses need different fixes.

### Was the plan wrong, or merely incomplete?

These are not the same.

An incomplete plan may just need better repo discovery.
A wrong plan usually points to a deeper misunderstanding.

### Is this a one-off or a recurring shape?

The first time I see something, I make a note.
The fifth time, I start thinking about process.

## This is useful beyond planning

The same analysis also helps with:

- handoff quality
- goal package quality
- AGENTS.md quality
- repo documentation quality

If plans keep failing because the same fact is missing, maybe the problem is not the plan. Maybe the repo is hiding the ball.

Machines are very good at revealing where your process is fuzzy.

Annoyingly good.

## One practical warning

Don't turn this into a blame machine.

The point is not to create a taxonomy of shame for every bad plan you or your agents ever produced.

The point is to build a feedback loop.

A denied plan is not embarrassing. A denied plan that teaches you nothing probably is.

## My current view

If you work with agents a lot, you should have some way of studying failed plans over time.

Not because failure is profound.

Mostly because repeated failure is trying very hard to tell you where the real friction is.

Might as well listen.

Worth considering.
