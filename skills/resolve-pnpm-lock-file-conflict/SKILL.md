---
name: resolve-pnpm-lock-file-conflict
description: Resolve a pnpm-lock.yaml Git conflict by regenerating and deduplicating the lockfile from resolved dependency inputs, then staging it. Use when pnpm-lock.yaml is conflicted during a merge, rebase, cherry-pick, or similar Git operation.
disable-model-invocation: false
---

# Resolve a `pnpm-lock.yaml` Conflict

Regenerate and stage a conflicted lockfile from resolved dependency inputs.

## Prerequisites

- Run this workflow only when `pnpm-lock.yaml` has a Git conflict.
- Resolve and stage all package manifests, pnpm configurations, and referenced patches before starting. These files must match the working tree. Other unrelated conflicts may remain.
- Do not read or output `.npmrc` contents when validating configuration.

## Resolve the Conflict

Run this exact command:

```bash
git restore -SW pnpm-lock.yaml &&
pnpm i --lockfile-only &&
pnpm dedupe --lockfile-only &&
git add pnpm-lock.yaml
```

If any command fails:
1. Stop execution.
2. Report the failure and any partial lockfile state.
3. Do not continue the Git operation.

## Confirm the Result

Verify that `pnpm-lock.yaml` meets these conditions:
- It has no Git conflicts.
- It is valid for the resolved dependency inputs.
- It is staged.

Report any remaining conflicts. Do not continue the Git operation, commit, or push.
