# AGENTS.md

Cross-platform dotfiles managed by [chezmoi](https://www.chezmoi.io/), targeting macOS (primary), Linux, and Windows.

## Commands

| Command               | Description                                                       |
| --------------------- | ----------------------------------------------------------------- |
| `task`                | Apply dotfiles, then sync Matt Pocock, anti-pua, and local skills |
| `task apply`          | Apply dotfiles only (`chezmoi apply -v`)                          |
| `task fmt`            | Format managed files with `dprint`                                |
| `task init`           | First-time setup — edit chezmoi config, install Homebrew packages |
| `task ocf`            | Open chezmoi config file in `$EDITOR`                             |
| `task bbd`            | Dump current Homebrew state to `configs/Brewfile`                 |
| `task bbi`            | Install packages from `configs/Brewfile`                          |
| `chezmoi diff`        | Preview pending changes before applying                           |
| `chezmoi edit <file>` | Edit a managed file through chezmoi                               |

## Key Concepts

**Source root:** `.chezmoiroot` sets `home/` as the chezmoi source directory — all managed dotfiles live under `home/`.

**Symlink-template pattern:** Actual config files live in `home/mydotfiles/` and are symlinked into place via `symlink_*.tmpl` files. For example, `home/symlink_dot_zshrc.tmpl` creates a symlink from `~/.zshrc` to the real file at `mydotfiles/sh/zshrc.sh`. This keeps configs editable in-place without chezmoi's `modify_` or `create_` prefixes.

**Platform targeting:** `.chezmoiignore` conditionally excludes files by OS (`{{ .chezmoi.os }}`). Templates branch on `darwin`, `linux`, and `windows` to produce platform-specific output.

**Data variables:** `.chezmoi.toml.tmpl` defines `work.email` and `work.name` used in git config templates.

**External dependencies:** `.chezmoiexternal.toml` clones `nushell/nu_scripts` into `mydotfiles/nu/nu_scripts` (refreshed weekly). Local skills live in the repository-root `skills/` directory. The default `task` uses the `skills` CLI to synchronize Matt Pocock skills, the `anti-pua`, `nvc`, and `rethink` skills from `p-toy-factory/anti-pua`, and local skills globally for universal and Claude Code agents; those directories are not managed by chezmoi.

## Code Style

EditorConfig is configured: tabs (4-wide) by default, 2-space indentation for `.nix`, `.js`, `.json`, `.json5`, `.yaml`, `.yml`.

## Commit Conventions

This project follows [Conventional Commits](https://www.conventionalcommits.org/).

Format: `<type>[optional scope]: <description>`

Common types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `perf`, `build`

Examples:

- `feat: add user login`
- `fix(auth): handle expired token`
- `feat!: drop Node 14 support` (breaking change)

## Detailed Documentation

- [Architecture](.agents/docs/architecture.md)

## Maintenance

When code changes cause descriptions in this file (commands, directory structure,
conventions, etc.) to become inaccurate, update AGENTS.md and the relevant files
in `.agents/docs/` to stay consistent.
