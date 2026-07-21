---
name: simplify-docs
description: Simplify documentation to make it easier to read while preserving meaning. Accepts specific files, git staged, or git unstaged changes.
---

# Simplify Documentation

Rewrite documentation to be simple and concise. Do not change the original meaning or lose key information.

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
2. Rewrite it to be simple and readable.
3. **CRITICAL:** Preserve all meaning, technical details, and instructions. Do not omit context.
4. `write` or `edit` the file with the new content.

## 4. Report

Give the user a brief summary of the simplified files.
