---
title: To optimize or not to optimize
date: 2018-02-21
tags: ["blog", "optimize", "bootcamp-journal"]
---

While we all have read & heard [Knuth’s immortal words](http://wiki.c2.com/?PrematureOptimization) on pre-optimization, the question becomes when is the right time to optimize, and more importantly, what to optimize?

>    "premature optimization is the root of all evil"

At what point do you really step into the trenches, and dig through your garbled code, which by this point is the direct function of all the accrued technical debt you thought you’ll handle later.

## The code speaks

A good time to optimize your code would be when the code tells you. Code that needs optimization would either be slower than expected, or consume absurdly large amounts of processing power or memory.

If you listen hard, you can sometimes hear the screams of the servers echoing in the basement. It’s either that, or the ghost of our last IT guy.

## What to optimize?

It’s imperative to keep your instincts aside when deciding which part of code requires optimization. Trust nothing but empirical evidence. The only scientific way to find the root cause of performance blockage is to profile your code. There’s a wide array of profiling tools at one’s disposal in almost every language.

Rules of Optimization:

1. Profile
2. Profile
3. Profile
4. Profile
5. Optimize
