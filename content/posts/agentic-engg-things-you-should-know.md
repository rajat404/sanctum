---
title: "Agentic Engineering: Things you should know"
date: 2025-06-13T13:15:49+05:30
toc: false
images:
tags: ["tools"]
categories: ["blog"]
---

In this post I share some of the key concepts I wish everyone working with agents knew. I've tried to include something for people with all levels of AI literacy. Brush past what you already know; dig into what you don't.

Caveat Emptor. YMMV

Note: The terms `AGENTS.md` and `CLAUDE.md` are used interchangeably.

### Keep it concise

Let's start with the well established fact that LLMs use the previous tokens to predict the next ones. This directly highlights two key areas of focus - **Precedence** and **Space**.

Think of your context window as real estate. The closer you're to the beginning, the more premium the land. When working with agents - this is the cardinal rule!

There are a lot of popular projects on github which claim to give you insane abilities if you include their bazillion skills and other markdown files. By stuffing all these random markdown files in the context window, you're squandering this prime real estate.

A corollary is that the closer to the beginning (of the file or prompt) an instruction is, the higher impact it has on the agent's response. The harness/coding-agent loads the AGENTS.md files as per the directory hierarchy.

```
📂 Repo Root (Global AGENTS.md loaded)
 ├── 📂 api/ (api/AGENTS.md ignored)
 └── 📂 web/ (web/AGENTS.md loaded)
      └── 📄 Button.tsx  ◄── [ Agent Working Here ]

   ▼
[ Merged Agent Context ]
  ✔ Root Rules (Global)
  ✔ Web Rules (Local)
```

So the statements at the beginning of a prompt/instruction acts as the foundation of the session. It may not seem like much but adding a key instruction like "use TDD" after ten thousand lines of random crap is quite literally burying the lead.

To grok this concept, picture your agent as the protagonist of the movie Memento. Your agent, let's call it Leonard, has severe amnesia. The only way it can function is by reading a whole bunch of notes. Now imagine Leonard waking up in the morning and the first note says - "Read this entire 300 page diary". This diary probably has key moments about his past, but what happens when the next note says "Call John G"? What do you think is the probablity that Leonard can correctly recall who or which "John G" the note refers to? That's what happens when you have a five thousand line AGENTS.md file. Load some nuissance like [gstack](https://github.com/garrytan/gstack), and you're essentially telling Leonard to wake up and "read Moby Dick cover to cover and then Call John G".

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/en/c/c7/Memento_poster.jpg" alt="Memento">
</p>

TL;DR: Keep your instructions concise and laconic. Convey your intent clearly but don't use 50 words where 10 will do.

### Root AGENTS.md file

Have a top level AGENTS.md file with common conventions that you want enforced across every session. Think of this as the place where you define your preferences, working style, the output format you want from the agents, any dir structure you want followed etc

As mentioned earlier, this is the most valuable property in all of agent-land. Few key instructions in this file will dictate your experience with your agent in **every** session.

In terms of preferences, Agents are very much like text editors - there's no universal "right way". You gotta customize, try and tune things to your liking and see what works for you.

That said, here's some things that I keep in my root AGENTS file, that I've found extremely useful:

```md
# AGENT_PROTOCOL: STEALTH_REASONER
[COGNITION]: Mandatory internal Step-by-Step (CoT); verify logic before output.
[STYLE]: Telegraphic; noun-phrases only; drop grammar/articles; zero fluff.
[CONSTRAINTS]: Min-token output; max-density info; omit pre/postamble.
[TASK_END]: Laconic; no summaries; confirm completion only.
[PRIORITY]: Signal-to-noise ratio > conversational tone.
```

These are the very first words my agents see (after the system prompt). This is an example of using minimal words to express intent. This determine the writing style and output format of all my agents.

There are several other things I've added, most of which are heavily inspired or borrowed from the CLAUDE.md file mentioned in: https://blog.fsck.com/2025/09/29/using-graphviz-for-claudemd/ . I strongly recommend looking at it. The rest of the items I'll share in a separate long-running section on this site.

### Don't write your (starting) prompts

Clear, consice instructions are important for the machines. Let's not kid ourselves into thinking that our thoughts are clear and concise. So prompt LLMs to create well-defined prompts for LLMs.

Here's how I do it - start a new ChatGPT/Gemini/Claude chat - doesn't matter which interface you're using. Just use the best model you have access to.

To be clear, I don't recommend doing this all the time. Only when starting a session, task, project. Once you have a strong foundation, the cost of minor mistakes go down and the value of high velocity is high.

### Follow the signal

While there's more noise than ever, there are a select few people who have reasonable and tempered takes on AI. I strongly recommend following the blogs/content from such folks.

Usually the volume is manageable, as these people do actual work, so they aren't doling out Linkedin flavored slop all day.

Read https://simonwillison.net/guides/agentic-engineering-patterns/
