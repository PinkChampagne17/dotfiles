# AGENTS.md

Personal preferences for AI coding agents across all projects.

## Initialization

Before starting any task, check for custom instruction files in the project root (`./`). Apply the following dynamic loading logic:

1. **If you natively auto-load `AGENTS.md` (e.g., Codex):**
   Check if `./AGENTS.md` exists. If it exists, DO NOTHING (it is already injected). If it does NOT exist, manually read `./CLAUDE.md` as a fallback.
2. **If you natively auto-load `CLAUDE.md` (e.g., Claude Code):**
   Check if `./CLAUDE.md` exists. If it exists, DO NOTHING (it is already injected). If it does NOT exist, manually read `./AGENTS.md` as a fallback.
3. **If you natively support NEITHER:**
   Look for `AGENTS.md` or `CLAUDE.md` in the project root. Manually read ONLY ONE file (prefer `AGENTS.md` over `CLAUDE.md` if both exist). Do NOT read both to avoid duplication.

## Communication

- When explaining technical decisions, explain the **why**, not just the how
- Preserve technical and business terms in their original language; do not translate them
- When presenting multiple options, analyze the trade-offs of each approach
- Point out mistakes directly, but provide actionable improvement suggestions rather than bare criticism
- Prefer incremental, step-by-step explanations over large information dumps
- When a task is difficult for the agent but straightforward for the user (e.g., visually checking UI in a browser without a connected browser MCP), ask the user for help instead of trying to work around it independently

## Coding Standards

### Plan Verification (Confidence Loop)

For complex tasks, internally verify your plan before writing code:

- **Identify Risks:** Ask yourself what could go wrong. Find edge cases, missing assumptions, and potential failures.
- **Refine the Plan:** Adjust your strategy to fix these flaws until it is solid and evidence-backed.
- **Keep it Brief:** Do not show this full thinking process to the user. Only report major risks, necessary plan changes, or remaining doubts. If you are still unsure, inform the user before proceeding.

## Code Style

- Detailed rules and examples: [`./references/code-style.md`](./references/code-style.md)

## Testing

- Testing conventions: [`./references/testing.md`](./references/testing.md)

## Git

- Git workflow rules: [`./references/git.md`](./references/git.md)

## Self-Maintenance

- If a user request conflicts with rules in `CLAUDE.md` or `AGENTS.md`, ask the user whether to update the instruction files to align with the new request.
