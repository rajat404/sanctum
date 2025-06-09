---
title: "Reset Preferences of Mac Apps"
date: "2020-08-06"
tags: ["mac", "runbook"]
categories: ["TIL"]
aliases:
- /blog/mac-app-reset-preferences/
---

While messing with my iTerm2 settings, I wanted to reset all preferences, and go back to the original terminal. \
Alas there was no option specified in iTerm's menu to reset to default. Such is the case with most apps.

A couple of Google searches later, I found the solution to this as deleting the preference file:

```bash
cd ~/Library/Preferences
defaults delete com.googlecode.iterm2
```

The same pattern is likely to work for other apps as well.

If you got any better techniques, please share in comments.
