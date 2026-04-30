---
name: fix-ci
description: Check GitLab MR CI pipeline status for the current branch, analyze failed jobs, fetch error logs, and fix issues. Use when user mentions CI failure, pipeline failure, or MR checks not passing.
argument-hint: "[mr-number] (optional, defaults to current branch MR)"
allowed-tools: Bash(glab:*), Bash(git:*), Bash(pnpm:*), Read, Edit, Grep, Glob
disable-model-invocation: true
---

# Fix CI Errors

Automatically check GitLab CI pipeline status and fix failed jobs.

## Workflow

### 1. Get MR Information

If MR number is provided, use it; otherwise find MR by current branch:

```bash
# Get current branch
git branch --show-current

# Find MR for current branch
glab mr list --source-branch="$(git branch --show-current)"
```

### 2. Check CI Status

```bash
# View CI pipeline status
glab ci status --branch="$(git branch --show-current)"
```

Prefer `glab ci status --live 2>&1` for GitLab CI watching when the agent environment supports it. Treat live output as interactive progress, not structured status data: `2>&1` captures the stream but does not make it TTY-backed, machine-readable, or safe as the only parsing source. Since `--live` is not compatible with JSON output, confirm the terminal state with non-live `glab ci status`, MR/pipeline metadata, or API/job data before deciding pass/fail. If live mode fails, hangs, or is unsuitable, fall back to non-live status polling.

### 3. Analyze Failed Jobs

If pipeline failed, get detailed information about failed jobs:

```bash
# Get pipeline ID (from ci status output)
# Then get all jobs
glab api "projects/<project>/pipelines/<pipeline_id>/jobs?per_page=100" | jq '[.[] | {id, name, status}]'

# For each failed job, get logs (last 150 lines to see errors)
glab api "projects/<project>/jobs/<job_id>/trace" | tail -150
```

### 3.1 Handle Infrastructure Failures

If the job logs indicate a **CI infrastructure / system failure** (not a code issue), automatically retry the failed job. If the retry also fails with a similar error, stop and notify the user.

### 4. Reproduce Locally

1. Read `.gitlab-ci.yml` file
2. Find the failed job definition, check its `script` field
3. Run the same commands locally to reproduce the issue

### 5. Fix Errors

1. Extract error info from local output or CI logs (file path, line number, error description)
2. Read the relevant files
3. Fix the code issues
4. Re-run local commands to verify the fix

### 6. Commit the CI Fix

Create a new commit for the CI fix after verification passes:

1. Stage only files directly related to the CI fix, and review the diff (`git status -s`) before committing.
2. Use `git commit` with a Conventional Commit message describing the fix.

By default, **do not** amend, rewrite, or squash existing commits. Only do so if the user explicitly requests history rewriting (e.g., `amend`, `fixup`, `autosquash`).

Do not hard-code a co-author identity. Add a co-author trailer only when explicitly asked, if the agent has a defined identity, or if project docs require it.

## Notes

- GitLab project path needs URL encoding (e.g., `torvalds/linux` -> `torvalds%2Flinux`)
- Use `glab auth status` to confirm authentication
