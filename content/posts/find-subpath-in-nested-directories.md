---
title: "Finding files/dirs with common subpath"
date: "2020-08-15"
tags: ["shell", "find"]
categories: ["TIL"]
aliases:
- /blog/find-subpath-in-nested-directories/
---

Recently I found myself looking for all the files of the same name & subpath. For context, it's a GitOps (or CI-Ops, if you're from the weaveworks gang 😛) repository, where the root directories are k8s clusters and the inner directories are components, with the leaf file being the [helmfile](https://github.com/roboll/helmfile) we use for deployments.

So a simplified structure would look something like:

```bash
.
├── cluster-A
│   ├── component-1
│   │   └── helmfile-012.yaml
│   └── component-2
│       └── helmfile-023.yaml
├── cluster-B
│   ├── component-1
│   │   └── helmfile-034.yaml
│   └── component-2
│       └── helmfile-045.yaml
└── cluster-C
    ├── component-1
    │   └── helmfile.yaml
    └── component-2
        └── helmfile.yaml

```

Easiest way to find all `helmfile.yaml` files for `component-1` in all clusters?

```bash
find . -path "*/cluster*/component-1/*.yaml"
```

And this would yield:

```bash
./cluster-A/component-1/helmfile-012.yaml
./cluster-C/component-1/helmfile-034.yaml
./cluster-B/component-1/helmfile.yaml
```

Et voilà!
