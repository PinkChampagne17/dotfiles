---
name: push-to-green
description: Push the current git branch, ask before using force-with-lease semantics when a normal push cannot proceed, then check the branch's MR or PR CI status. If CI fails, inspect failed jobs, make the smallest safe fix, push again, and repeat until CI passes or user input is required.
argument-hint: "[remote] [branch] (optional, defaults to upstream/current branch)"
allowed-tools: Bash(git:*), Bash(glab:*), Bash(gh:*), Bash(pnpm:*), Bash(npm:*), Bash(yarn:*), Bash(bun:*), Bash(jq:*), Read, Edit, Grep, Glob, AskUserQuestion
disable-model-invocation: true
---

# Push and Fix CI

Push the current branch, monitor its MR/PR CI pipeline, and automatically fix failures until it passes.

## Workflow

### 1. Setup & Push

- **Resolve Targets:** Parse `$ARGUMENTS` (0 args = upstream/current branch, 1 arg = remote/current branch, 2 args = remote/branch). If unresolved, ask the user.
- **Uncommitted Changes:** Pause if uncommitted changes exist. Do not commit, stash, or discard without user permission.
- **Push:** Perform a normal `git push`.
- **Force Push Guard:** If rejected (e.g., diverged branch), **ask** the user before retrying with `--force-with-lease`. _Never_ use unsafe force push. Stop on other errors unless easily fixed (like missing upstream).

### 2. CI Monitoring

- **Locate MR/PR:** Use `glab` (GitLab) or `gh` (GitHub) based on the remote URL. If no MR/PR exists, report and stop. Do not create one unless asked.
- **Poll Status:** Check CI status every 3 minutes until terminal.
  - For GitLab, prefer `glab ci status --live 2>&1` to watch the pipeline in real time when the agent environment supports it. Treat live output as interactive progress, not structured status data: `2>&1` captures the stream but does not make it TTY-backed, machine-readable, or safe as the only parsing source. Since `--live` is not compatible with JSON output, confirm the terminal state with non-live `glab ci status`, MR metadata, or API/job data before reporting success or failure. If live mode cannot run cleanly, fall back to the 3-minute polling loop.
  - **Pass:** Done. Proceed to report.
  - **Wait:** If running/pending.
  - **Fail/Cancel:** Proceed to diagnosis.

### 3. Diagnosis & Fix

- **Analyze Logs:** Fetch failed job logs via `glab` or `gh`. Rely on log traces—not job names—to identify the exact error, file, and CI step.
- **Infra Failures:** Retry obvious infrastructure errors (network, runner down) **once**. If it fails again, report and stop.
- **Code Failures:**
  1. Review the CI config and reproduce the failure locally if practical.
  2. Apply the smallest safe fix. Avoid broad refactors.
  3. Ask the user if the fix is ambiguous or affects product behavior.
  4. Validate locally, push, and resume CI polling.

### 4. Completion Report

- **Success:** Summarize the pushed branch, MR/PR identifier, final status, and any applied fixes.
- **Early Stop:** Detail the exact blocker, the last check, and the required user action to continue.
