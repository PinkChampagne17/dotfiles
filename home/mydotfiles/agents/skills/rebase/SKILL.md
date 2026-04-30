---
name: rebase
description: Rebase current or specified branch onto a target branch. Auto-resolves pnpm-lock.yaml conflicts; pauses for manual resolution on other conflicts. Provides rollback option.
argument-hint: "<target-branch> or <source-branch> <target-branch>"
allowed-tools: Bash(git:*), Bash(pnpm:*), AskUserQuestion
disable-model-invocation: true
---

# Git Rebase Skill

Rebase branches onto a target branch with automatic conflict handling for `pnpm-lock.yaml`.

## Usage

- `/rebase <target-branch>` - Rebase current branch onto `origin/<target-branch>`
- `/rebase <source-branch> <target-branch>` - Checkout `<source-branch>` and rebase onto `origin/<target-branch>`

## Instructions

Follow these steps in order:

### Step 1: Parse Arguments

Parse `$ARGUMENTS`:
- If empty: Ask user to provide target branch using AskUserQuestion
- If 1 argument: `TARGET_BRANCH = $ARGUMENTS`, rebase current branch
- If 2 arguments: `SOURCE_BRANCH = first arg`, `TARGET_BRANCH = second arg`

### Step 2: Check Working Directory

Run `git status --porcelain` to check for uncommitted changes.

If there are uncommitted changes, stop and inform the user:
> "You have uncommitted changes. Please commit or stash them before rebasing."

### Step 3: Save State for Rollback

Record the current state:
```bash
ORIGINAL_BRANCH=$(git branch --show-current)
ORIGINAL_HEAD=$(git rev-parse HEAD)
```

Inform user:
> "Saved current state. To rollback after rebase, run: `git reset --hard <ORIGINAL_HEAD>`"

### Step 4: Switch Branch (if applicable)

If `SOURCE_BRANCH` is set (2 arguments provided):
```bash
git checkout <SOURCE_BRANCH>
```

### Step 5: Fetch Remote

```bash
git fetch origin
```

### Step 6: Execute Rebase

```bash
git rebase origin/<TARGET_BRANCH>
```

### Step 7: Handle Conflicts

If rebase fails with conflicts:

1. Get list of conflicted files:
   ```bash
   git diff --name-only --diff-filter=U
   ```

2. **If ONLY `pnpm-lock.yaml` is conflicted**, auto-resolve:
   ```bash
   git add pnpm-lock.yaml
   git restore -SW pnpm-lock.yaml
   pnpm i
   git add pnpm-lock.yaml
   git rebase --continue
   ```
   Repeat this step if subsequent commits also have `pnpm-lock.yaml` conflicts.

3. **If other files are conflicted**:
   - Stop immediately
   - List all conflicted files to the user
   - Use `AskUserQuestion` to ask user what they want to do next. Provide options like:
     - "I'll resolve conflicts manually, then continue"
     - "Abort this rebase"
   - The user can also choose "Other" to specify a custom action
   - Wait for user's instruction before proceeding

### Step 8: Ask About Push (on success)

After rebase completes successfully, use `AskUserQuestion` to ask:
> "Rebase completed successfully. Do you want to force-push to remote?"

Options:
- "Yes, push with --force-with-lease"
- "No, I'll push later"

If user chooses to push:
```bash
git push --force-with-lease
```

### Step 9: Provide Rollback Information

After everything is done, remind the user:
> "Rebase complete. If you want to undo this rebase, run: `git reset --hard <ORIGINAL_HEAD>`"

Replace `<ORIGINAL_HEAD>` with the actual commit hash saved in Step 3.
