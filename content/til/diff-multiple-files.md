---
title: "Diff on Multiple Files"
date: "2020-08-15"
---

I needed to check the differences between 4 files. I wanted something like sdiff, but better UX.
After a bit of looking around, turns out the right answer has been staring me in the face.
`vim` ships with that ability out of the box!

```bash
vim -d file-A file-B file-C file-D
```

That's it! 🤯
