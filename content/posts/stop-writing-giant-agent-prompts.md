---
title: "Stop Writing Giant Agent Prompts"
date: 2026-07-10T23:46:00+05:30
toc: false
tags: ["tools", "agents", "workflow"]
categories: ["blog"]
draft: true
---

I have a mild allergy to giant prompts.

You know the kind. A sprawling markdown slab with goals, half-baked assumptions, implementation notes, tradeoffs, open questions, stray caveats, and a motivational speech thrown in for good measure.

People love these because they feel comprehensive.

Machines, in my experience, do not love them nearly as much.

What I've found works better is splitting the intent into a small goal package instead of one mega-prompt.

## The problem with the all-in-one prompt

The moment a prompt starts trying to do all of these at once:

- define the objective
- preserve context
- record facts
- explain rationale
- prescribe execution
- enumerate risks

it becomes annoying for both parties.

For me, it's harder to review.

For the model, it's harder to separate:

- what is true
- what is decided
- what is still uncertain
- what should actually be done next

Think of it as mixing code, config, logs and design notes into one file and then pretending the resulting soup is "context".

Technically true. Operationally cursed.

## What I prefer instead

I like splitting this into three small files:

- `goal.md`
- `facts.md`
- `plan.md`

The names are not magical. The separation is.

### `goal.md`

This is the launch point.

Short objective. Clear done condition. Maybe one or two exclusions if violating them would be expensive.

This should be boring. If it starts looking clever, it's probably too long.

### `facts.md`

This is the contract.

Only put stable, testable, accepted truths here.

Not rationale.
Not alternatives.
Not implementation chatter.

Just things that should remain true while the work is being done.

For example:

- ownership boundaries
- source-of-truth paths
- explicit exclusions
- user-visible behavior expectations
- verification requirements

This is the file that stops future-you from gaslighting present-you.

### `plan.md`

This is where the actual execution path lives.

Ordered steps. Concrete files. Validation commands. Risks. Maybe a note on which skills/tools are useful and which ones are a distraction.

The plan can be opinionated. The facts should not be.

That distinction matters more than it sounds.

## Why this works better

A good goal package gives the model different layers of certainty.

- `goal.md` says what we're doing
- `facts.md` says what must remain true
- `plan.md` says how we currently think it should be done

That means the model doesn't need to keep re-deriving the same structure from a pile of markdown every time the session gets resumed, forked, compacted or handed off.

It also makes human review much easier.

If I disagree with the implementation path, I edit the plan.
If I disagree with the constraints, I edit the facts.
If I disagree with the objective, I edit the goal.

No archaeology expedition required.

## There's another benefit

This separation is also good at exposing fuzzy thinking.

When you try to write `facts.md`, you very quickly discover whether something is:

- actually decided
- merely preferred
- still being debated
- or completely made up in the heat of the moment

This is inconvenient, of course.

Which is precisely why it is useful.

## What not to do

A few traps I've run into:

- stuffing rationale into `facts.md`
- making `goal.md` so detailed that it becomes a second `plan.md`
- turning `plan.md` into a design novel
- pretending open questions are facts because the file needed to look complete

The package only works if each file has a job and sticks to it.

## My current heuristic

If a future agent can resume the work without rereading the entire conversation, the package is doing its job.

If they still need the original transcript to untangle what was decided, then congratulations, you've reinvented the giant prompt in triplicate.

Which, while technically impressive, is not the goal.

Hope this helps.
