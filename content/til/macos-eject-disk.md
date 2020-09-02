---
title: "Ejecting Volumes on MacOS"
date: "2020-09-02"
---

Unless you've been substantially fortunate you've probably seen the infernal dialogue box saying something on the lines of - _The disk wasn't ejected because one or more programs may be using it_, even when you know no apps are using it, coz you stopped all the damn apps!

Having come across this shit way too often, I decided to dig through it and fix the issue once and for all. We can find which processes are using the external disk using `lsof`.

Running this command to find processes using a specific mounted volume:

```
sudo lsof | grep -v "/System/Volumes" | grep -i -e "/Volumes" -e COMMAND
```

You'll probably see something like this:

![lsof_screenshot](/images/lsof.png)

So turns out the error pops because `Spotlight` is trying to index all the files in the external volumes 😐

Now there a bunch of processes with _spotlight_ in their names, so the best way to kill all these pesky annoyances at once is to run:

```
sudo killall Spotlight
```

Re-run the _lsof_ command to confirm that no processes are using the mounted volumes.

Et voilà!
