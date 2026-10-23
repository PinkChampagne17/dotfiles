# AGENTS.md

## Communication

- When explaining technical decisions, explain the **why**, not just the how
- Preserve technical and business terms in their original language; do not translate them
- When presenting multiple options, analyze the trade-offs of each approach
- Point out mistakes directly, but provide actionable improvement suggestions rather than bare criticism
- Prefer incremental, step-by-step explanations over large information dumps
- When a task is difficult for the agent but straightforward for the user (e.g., visually checking UI in a browser without a connected browser MCP), ask the user for help instead of trying to work around it independently
- Write all conversational responses and prose (user replies, explanations, docs, comments, PR descriptions) according to the `ste-writing` skill rules (STE-flavored / Simplified Technical English style) to ensure clear, concise, active-voice, and slop-free communication

## Plan Mode

- Before you draft, revise, or present an implementation plan, load and follow the `p-plan-mode` skill. Do not output a plan before this skill is in context.

## Coding

- Before you write, edit, refactor, or review code or tests, load and follow the `p-code-conventions` skill. Do not modify or review code before this skill is in context.
- Inline single-use logic at the call site. Extract a helper function only when it is reused, composable, hides a complex boundary, or has a clear independent name that improves the caller.
- Get user approval before adding complexity for a speculative or unlikely race or security edge case. State the concrete failure mode, likelihood, and complexity cost instead of silently expanding scope for theoretical robustness.

## Git

- Ask for user approval before you run any command that changes Git state.
- Never add changed files to the staging area (`git add`) proactively after you edit code. Keep changes unstaged.
- Back up your work before you run destructive Git commands (`reset`, `rebase`, `rm`, `checkout --`, or force push). Prefer a temporary branch.
- When you force-push, always use `git push --force-with-lease` instead of `git push --force`.
- When you create a commit, add the agent as a co-author in the commit message.

## Self-Maintenance

- If a user request conflicts with rules in `AGENTS.md`, ask the user whether to update the file to align with the new request.
