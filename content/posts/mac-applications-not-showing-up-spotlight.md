---
title: "Mac Spotlight Applications list fix"
date: "2020-12-30"
tags: ["TIL", "mac", "runbook"]
aliases:
- /blog/mac-applications-not-showing-up-spotlight/
---

If newly installed applications are not showing up in Spotlight, then try restarting Spotlight indexing:

```bash
sudo mdutil -a -i off
sudo mdutil -a -i on
```

If that doesn't work, then try rebooting the service as well:

```bash
sudo mdutil -a -i off
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
sudo mdutil -a -i on
```

Source: https://apple.stackexchange.com/a/142523
