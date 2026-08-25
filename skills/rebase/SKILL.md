---
name: rebase
description: Rebase current or specified branch onto a target branch. Auto-resolves pnpm-lock.yaml conflicts; pauses for manual resolution on other conflicts. Provides rollback option.
argument-hint: "<target-branch> or <source-branch> <target-branch>"
disable-model-invocation: true
---

# Git Rebase

## Invocation

- `/rebase <target-branch>` rebases the current branch onto `origin/<target-branch>`.
- `/rebase <source-branch> <target-branch>` checks out `<source-branch>` before rebasing it onto `origin/<target-branch>`.
- If no target branch is provided, ask the user for one.

## Contract

- Require a clean worktree. Before switching branches or rebasing, record the original branch and HEAD so the user has an exact rollback point.
- Fetch `origin` and rebase the selected branch onto `origin/<target-branch>`.
- use the `resolve-pnpm-lock-file-conflict` skill to resolve `pnpm-lock.yaml`.
- Pause for user direction when any other file is conflicted; do not auto-resolve it. Use `AskUserQuestion` with these options:
  - "I'll resolve conflicts manually, then continue"
  - "Abort this rebase"
  - "Other"
- On completion, report the recorded rollback point. Use `AskUserQuestion` to ask whether to force-push:
  - "Yes, push with --force-with-lease"
  - "No, I'll push later"
    Push rewritten history only with explicit user authorization, using `git push --force-with-lease`.
