# AGENTS.md

## Working Principles

- Before changing behavior, inspect the relevant source, configuration, and real callers.
- If this file conflicts with the actual implementation, follow the actual implementation.
- Preserve unrelated staged and unstaged changes.
- Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.

## Where to Look

- For tasks and their side effects, read [`taskfile.yml`](taskfile.yml) and the taskfiles it includes.
- For the chezmoi source root and template routing, read [`.chezmoiroot`](.chezmoiroot), [`home/.chezmoiignore`](home/.chezmoiignore), [`.chezmoiexternal.toml`](home/.chezmoiexternal.toml), and [`.chezmoi.toml.tmpl`](home/.chezmoi.toml.tmpl).
- For managed configuration and symlink mappings, inspect [`home/`](home/) and the relevant `symlink_*.tmpl` files.
- For formatting rules, read [`.editorconfig`](.editorconfig) and [`dprint.jsonc`](dprint.jsonc).
- For established history conventions, inspect recent commits with `git log`.

## Maintenance

Update this file only for durable working constraints that cannot be inferred from source. Do not duplicate commands, layout, or implementation details here.
