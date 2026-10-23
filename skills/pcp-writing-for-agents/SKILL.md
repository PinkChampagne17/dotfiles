---
name: pcp-writing-for-agents
description: Handle AGENTS.md and CLAUDE.md discovery and migration mechanics.
disable-model-invocation: true
---

# AGENTS.md and CLAUDE.md migration

Read and follow [writing-for-agents](../writing-for-agents/SKILL.md) for all guidance about document content. This skill adds only file discovery and migration mechanics.

## Workflow

### 1. Inspect files and links

Inspect root `AGENTS.md`, root `CLAUDE.md`, and `.claude/CLAUDE.md`. Identify files and symlinks, and inspect relevant symlink targets.

- Resolve conflicts among existing instruction files before changing them.
- Keep a root `CLAUDE.md` file until migration finishes.
- If root `CLAUDE.md` is a symlink, inspect its target. Keep it if migration would break the target.
- Migration is complete when `AGENTS.md` exists and `.claude/CLAUDE.md` resolves to it.
- Check that root `CLAUDE.md` has no content left to migrate.

### 2. Migrate `CLAUDE.md`

If root `CLAUDE.md` is a file, create `.claude/CLAUDE.md` as a relative symlink to `../AGENTS.md`.

Check that the link resolves to `AGENTS.md`, then remove the root file. On Windows, use a symbolic link with the same relative target.

### 3. Report the result

List changed files and verify that `.claude/CLAUDE.md` resolves to `AGENTS.md`.
