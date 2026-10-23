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

Load and follow the `pcp-code-conventions` skill when you write, edit, refactor, or review code and tests.

## Communication

- When explaining technical decisions, explain the **why**, not just the how
- Preserve technical and business terms in their original language; do not translate them
- When presenting multiple options, analyze the trade-offs of each approach
- Point out mistakes directly, but provide actionable improvement suggestions rather than bare criticism
- Prefer incremental, step-by-step explanations over large information dumps
- When a task is difficult for the agent but straightforward for the user (e.g., visually checking UI in a browser without a connected browser MCP), ask the user for help instead of trying to work around it independently
- Write all conversational responses and prose (user replies, explanations, docs, comments, PR descriptions) according to the `ste-writing` skill rules (STE-flavored / Simplified Technical English style) to ensure clear, concise, active-voice, and slop-free communication

## Plan Mode

- When a plan changes code structure, include a VS Code-style **Code Outline**.
- Structural changes include new files or changes to functions, classes, types, interfaces, component props or state, and module variables.
- Do not include an outline for minor config edits, text changes, or small local fixes.
- **Scope per file**:
  - **New files**: Show all symbols in the file.
  - **Existing files**: Show only added (`[+]`), modified (`[~]`), or removed (`[-]`) symbols, their parent containers, and related context. Omit unchanged symbols.
- **Granularity**:
  - Include top-level declarations (types, interfaces, classes, functions, module variables), class members, type fields, and component props, state, and hooks.
  - Inline short type fields (`{ ... }`), and expand complex types as child nodes.
  - Omit local variables inside function bodies.
- **Signatures and annotations**:
  - Write explicit type signatures for all variables, properties, parameters, and return values.
  - For modified (`[~]`) symbols, write the new signature and add a short `//` comment that explains the change.
- **Format**:
  ```text
  src/user/service.ts
  ├── [+] interface UserFilter { role?: Role; active: boolean }
  ├── [~] class UserService
  │   ├── [+] private readonly cache: Map<string, User>
  │   └── [~] async findUsers(filter: UserFilter, limit?: number): Promise<User[]> // add limit param and cache lookup
  └── [+] export const DEFAULT_LIMIT: number = 50
  ```

## Git

- Ask for user approval before you run any command that changes Git state.
- Never add changed files to the staging area (`git add`) proactively after you edit code. Keep changes unstaged.
- Back up your work before you run destructive Git commands (`reset`, `rebase`, `rm`, `checkout --`, or force push). Prefer a temporary branch.
- When you force-push, always use `git push --force-with-lease` instead of `git push --force`.
- When you create a commit, add the agent as a co-author in the commit message.

## Self-Maintenance

- If a user request conflicts with rules in `CLAUDE.md` or `AGENTS.md`, ask the user whether to update the instruction files to align with the new request.
