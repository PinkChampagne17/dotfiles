---
name: simplify-docs
description: Simplify documentation to make it easier to read while preserving meaning. Accepts specific files, git staged, or git unstaged changes. Uses ste-writing principles as assistance to improve clarity and remove filler.
---

# Simplify Documentation

Rewrite documentation to be clear, concise, and easy to read. Do not change the original meaning or lose key information.

## 1. Determine Inputs

Check if the user provided an input source (specific files, "git unstaged changes", or "git staged changes").

If not, use the `question` tool to ask. Provide these options:

- **Label:** `git unstaged changes` | **Description:** `Use modified files that are not yet staged`
- **Label:** `git staged changes` | **Description:** `Use files that are staged for commit`

_(Users can also type specific filenames)._

## 2. Gather Files

Get the target files based on the input:

- **"git unstaged changes"**: Run `git diff --name-only` (add `git ls-files -o --exclude-standard` for untracked files).
- **"git staged changes"**: Run `git diff --cached --name-only`.
- **Specific filenames**: Use those files directly.

_Filter for documentation files (e.g., `.md`, `.txt`) unless otherwise requested._

## 3. Simplify

For each file:

1. `read` the current content.
2. Simplify and rewrite the content to improve readability, flow, and conciseness.
   - **CRITICAL:** Preserve all meaning, technical details, and instructions. Do not omit context.
3. **Use `ste-writing` guidance to assist simplification:**
   - Refer to or load the `ste-writing` skill to eliminate AI slop, hype adjectives, and redundant filler.
   - Prefer simple, common words (`use` over `utilize`, `start` over `initiate`).
   - Use active voice and direct verbs where appropriate (`analyze` over `perform an analysis`).
   - Keep sentence structures clean and use vertical lists for sequential steps.
4. `write` or `edit` the file with the simplified content.

## 4. Report

Give the user a brief summary of the simplified files.
