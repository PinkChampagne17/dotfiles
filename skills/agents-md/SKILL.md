---
name: agents-md
description: Generate an AGENTS.md for the current project. Analyzes project structure, conventions, and existing docs to create agent guidance.
disable-model-invocation: true
---

# Generate AGENTS.md

Analyze the current project and generate an `AGENTS.md` file following the open [AGENTS.md](https://agents.md/) format. AGENTS.md is a dedicated, predictable place to provide context and instructions that help AI coding agents work on the project — think of it as a README for agents.

## Workflow

### Step 1: Check for existing CLAUDE.md

Check whether `CLAUDE.md` exists at the project root and determine its type (real file or symlink). Also check if `.claude/CLAUDE.md` already exists as a symlink to `../AGENTS.md`.

**macOS / Linux:**

```bash
# Check CLAUDE.md type
if [ -L CLAUDE.md ]; then echo "symlink"; elif [ -f CLAUDE.md ]; then echo "real-file"; else echo "not-found"; fi
# Check existing migration
[ -L .claude/CLAUDE.md ] && readlink .claude/CLAUDE.md
```

**Windows (PowerShell):**

```powershell
# Check CLAUDE.md type
if (Test-Path CLAUDE.md) {
  if ((Get-Item CLAUDE.md).LinkType -eq 'SymbolicLink') { "symlink" } else { "real-file" }
} else { "not-found" }
# Check existing migration
if (Test-Path .claude\CLAUDE.md) { (Get-Item .claude\CLAUDE.md).Target }
```

- If `.claude/CLAUDE.md` already symlinks to `../AGENTS.md` → migration done, skip to Step 3.
- If `CLAUDE.md` is a real file → read its content and proceed to Step 2.
- If `CLAUDE.md` does not exist → skip to Step 3.

### Step 2: Evaluate and migrate CLAUDE.md

Read the content of `CLAUDE.md`. Determine whether it can be reused as the basis for `AGENTS.md` with simple term replacements.

**If the content is sufficient** (covers project overview, commands, conventions, etc.):

1. Use the content as the basis for AGENTS.md, replacing Claude-specific terminology:
   - "Claude Code" / "claude.ai/code" → "AI coding agent"
   - "This file provides guidance to Claude Code" → "This file provides guidance to AI coding agents"
   - "CLAUDE.md" → "AGENTS.md"
   - Other Claude-specific references → generic equivalents
2. Write the result as `AGENTS.md`
3. Remove the original `CLAUDE.md` and create the symlink for Claude Code:

   **macOS / Linux:**
   ```bash
   rm CLAUDE.md
   mkdir -p .claude
   ln -s ../AGENTS.md .claude/CLAUDE.md
   ```

   **Windows (PowerShell):**
   ```powershell
   Remove-Item CLAUDE.md
   New-Item -ItemType Directory -Path .claude -Force | Out-Null
   New-Item -ItemType SymbolicLink -Path .claude\CLAUDE.md -Target ..\AGENTS.md
   ```

4. Skip to Step 4.

**If the content exists but is clearly insufficient** (e.g. only a few lines, missing key information):

1. Keep the existing content as a starting point
2. Proceed to Step 3 to supplement it with project analysis
3. After Step 3, still perform the migration (remove original, create symlink) as described above

### Step 3: Analyze project and generate AGENTS.md

This step runs when there is no CLAUDE.md, or when CLAUDE.md content is insufficient.

Scan the project root to understand its structure. Look for:

- **Package manager / build tool**: `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, `Makefile`, `CMakeLists.txt`, etc.
- **Scripts / commands**: build, test, dev, lint, format commands defined in the project
- **Test framework & config**: vitest, jest, pytest, cargo test, go test, etc.
- **CI/CD config**: `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, etc.
- **Linter / formatter config**: `.eslintrc`, `.prettierrc`, `.editorconfig`, `rustfmt.toml`, `.golangci.yml`, etc.
- **Existing documentation**: `README.md`, `CONTRIBUTING.md`, `docs/`, etc.

Generate `AGENTS.md` at the project root. If there was insufficient CLAUDE.md content from Step 2, incorporate and supplement it with analysis results.

#### Content guidelines

Follow these principles when deciding what goes into AGENTS.md:

**Cover what matters** — Add sections that help an agent work effectively with the project. Popular choices:

- Project overview
- Build and test commands
- Code style guidelines
- Testing instructions
- Security considerations

**Add extra instructions** — Commit messages or pull request guidelines, security gotchas, large datasets, deployment steps: anything you'd tell a new teammate belongs here too.

**Large monorepo? Use nested AGENTS.md files for subprojects** — Place another AGENTS.md inside each package or subproject. Agents automatically read the nearest file in the directory tree, so the closest one takes precedence and every subproject can ship tailored instructions. The root AGENTS.md can link to sub-AGENTS.md files, and those can link to their own children — forming a tree structure that enables on-demand loading. Only the relevant branch of the tree is read for any given task.

#### Content to keep in AGENTS.md (read every task)

These sections are typically useful for every task an agent performs:

- **Project Overview** — One-line description of the project and its tech stack
- **Setup Commands** — install, build, dev, test commands
- **Code Style** — Key code style rules (indentation, quotes, naming conventions, etc.)
- **Testing** — How to run tests, testing conventions
- **PR/Commit Conventions** — Commit message format, PR title format, review process

#### Content to split into `.agents/docs/` (read on demand)

If a piece of content is NOT needed for every task, put it in a separate file under `.agents/docs/`. Create only the files that are relevant to the project:

- `.agents/docs/architecture.md` — Detailed architecture, module relationships, directory deep-dive
- `.agents/docs/api.md` — API endpoints and interface documentation
- `.agents/docs/workflows.md` — Deployment, release, and complex workflow processes
- Other files as the project demands

Reference them from AGENTS.md with relative links:

```markdown
## Detailed Documentation

- [Architecture](.agents/docs/architecture.md)
- [API Reference](.agents/docs/api.md)
```

#### Creative freedom

The outline above is a reference, not a rigid template. Add, remove, or restructure sections based on what the project actually needs. If you identify information that would help future agent tasks — add it. The goal is practical usefulness, not format compliance.

### Step 4: Ask About Conventional Commits

Use `AskUserQuestion` to ask the user whether the generated AGENTS.md should include a [Conventional Commits](https://www.conventionalcommits.org/) section.

**If the user confirms**, add the following section to AGENTS.md (place it under an appropriate heading such as "Commit Conventions" or "PR/Commit Conventions"):

```markdown
## Commit Conventions

This project follows [Conventional Commits](https://www.conventionalcommits.org/).

Format: `<type>[optional scope]: <description>`

Common types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `perf`, `build`

Examples:

- `feat: add user login`
- `fix(auth): handle expired token`
- `feat!: drop Node 14 support` (breaking change)
```

**If the user declines**, skip this section entirely — do not add any commit convention guidance.

### Step 5: Add Consistency Maintenance Note

Include a visible note in AGENTS.md (e.g. at the end, or in a dedicated section):

```markdown
## Maintenance

When code changes cause descriptions in this file (commands, directory structure,
conventions, etc.) to become inaccurate, update AGENTS.md and the relevant files
in `.agents/docs/` to stay consistent.
```

### Step 6: Record Reusable Learnings

Throughout the task, if you discover something that **required multiple attempts or trial-and-error** to figure out, add it to AGENTS.md or the appropriate `.agents/docs/` file.

**Litmus test:** If another agent could discover it by reading existing code, config files, or documentation — don't record it. Only record things you had to learn the hard way.

Examples of what to record:

- Commands that must run in a specific non-obvious order
- Environment or CI quirks that cause silent failures
- Workarounds for undocumented behavior

Do NOT record things that are discoverable by reading code or config files — such as which tools are configured, what directives or imports existing files use, or naming patterns already visible in the codebase.

This is an ongoing practice — any time you complete a task and realize a future agent would waste time rediscovering something you struggled with, update the relevant AGENTS.md.

### Step 7: Report Results

- List all files created or modified
- If CLAUDE.md migration was performed, verify the symlink:
  - **macOS / Linux:** `ls -la .claude/CLAUDE.md`
  - **Windows:** `Get-Item .claude\CLAUDE.md | Select-Object LinkType, Target`
