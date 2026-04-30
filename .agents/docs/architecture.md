# Architecture

## Directory Layout

| Path | Description |
|------|-------------|
| `home/` | Chezmoi source directory (set by `.chezmoiroot`) |
| `home/mydotfiles/sh/` | Zsh/Bash configs (zshrc, zprofile, aliases, env) |
| `home/mydotfiles/nu/` | Nushell configs |
| `home/mydotfiles/claude/` | Claude Code settings and custom skills |
| `home/mydotfiles/starship/` | Starship prompt theme |
| `home/mydotfiles/clash/` | Clash proxy configs |
| `home/mydotfiles/windows/` | Windows-specific configs (winget export) |
| `home/dot_gitconfig` | Git configuration (main config) |
| `home/dot_gitconfig_*.tmpl` | Git configuration (dynamic/work includes, templated) |
| `home/dot_bashrc` | Bash config for Linux |
| `home/dot_claude/` | Claude Code dotfile configs |
| `home/AppData/` | Windows AppData configs |
| `home/Library/` | macOS Library configs |
| `configs/` | Brewfile, iTerm2 profile, distrobox config, task definitions |
| `nixos/` | NixOS flake configs (independent of chezmoi) |
| `scripts/` | Utility scripts (brew dump, alias parsing, platform setup) |
| `via/` | Keyboard firmware configs (not managed by chezmoi) |

## Symlink-Template Pattern

The repo uses a pattern where real config files live in `home/mydotfiles/` and chezmoi creates symlinks to them via `symlink_*.tmpl` template files in `home/`.

Example: `home/symlink_dot_zshrc.tmpl` contains:

```
{{ .chezmoi.homeDir }}/mydotfiles/sh/zshrc.sh
```

When `chezmoi apply` runs, it creates `~/.zshrc` as a symlink pointing to `~/mydotfiles/sh/zshrc.sh`. This means:

- Edit the files in `home/mydotfiles/` directly — changes take effect immediately since the symlink is already in place
- To add a new managed file, create the real file in `home/mydotfiles/` and a corresponding `symlink_*.tmpl` in `home/`

## Platform Targeting

`.chezmoiignore` uses chezmoi template syntax to conditionally exclude files per OS:

- **macOS (`darwin`)**: Gets `.zshrc`, `.zprofile`, `.proto`, `Library/` configs
- **Linux**: Gets `.bashrc`, Nushell configs (`.config/nushell`)
- **Windows**: Gets `AppData/`, `.wslconfig`, `winget-export.json`

Templates (`.tmpl` files) also branch on `{{ .chezmoi.os }}` for platform-specific content within a single file.

## Task Runner

The project uses [Task](https://taskfile.dev/) (Taskfile) as a task runner. The root `taskfile.yml` includes sub-taskfiles from `configs/` and `nixos/`.

Key tasks:

- `task` (default) — runs `chezmoi apply -v`
- `task init` — first-time setup flow
- `task configs:bbd` / `task bbd` — dump Homebrew state to Brewfile
- `task configs:bbi` / `task bbi` — install from Brewfile

## External Dependencies

`.chezmoiexternal.toml` in `home/` pulls in external repos:

- `nushell/nu_scripts` — cloned into `mydotfiles/nu/nu_scripts`, refreshed weekly

## Data Variables

`.chezmoi.toml.tmpl` defines template data:

- `work.email` — work email for git config
- `work.name` — work name for git config

These are prompted during `chezmoi init` and used in `dot_gitconfig_work.tmpl`.
