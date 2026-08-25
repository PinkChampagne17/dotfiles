# Pink Champagne's dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) and [Task](https://taskfile.dev/).

## Overview

- **OS Support**: macOS, Windows, NixOS, and Linux
- **Dotfile Engine**: chezmoi with modular templates and symlinks
- **Task Automation**: Taskfile for setup, updates, and maintenance
- **Toolchain**: proto for tool and language versioning
- **Shells**: Zsh, Nushell, and Starship prompt
- **Terminal and Editor**: Ghostty (Terminal), Zed (Editor)
- **AI Coding Agents**: Unified agent rules (`AGENTS.md`, `CLAUDE.md`, opencode) and global skills

---

## Quickstart

### 1. Prerequisites

Install `chezmoi` and `task` with your package manager:

- **macOS**:
  ```bash
  brew install chezmoi go-task
  ```
- **Windows**:
  ```powershell
  winget install twpayne.chezmoi
  winget install Task.Task
  # or: scoop install chezmoi task
  ```
- **NixOS and Linux**:
  ```bash
  nix-env -iA nixpkgs.chezmoi nixpkgs.go-task
  # or use your system package manager (pacman, apt)
  ```

You can also download prebuilt binaries from the official [chezmoi](https://www.chezmoi.io/install/) and [Task](https://taskfile.dev/installation/) installation guides.

### 2. Initialize and Apply

```bash
chezmoi init git@github.com:PinkChampagne17/dotfiles.git
task init
```

> **Note**: `task init` opens `~/.config/chezmoi/chezmoi.toml` to configure local template variables (such as Git identities and API keys). It then applies configurations and installs skills.

---

## Daily Workflows

| Command               | Description                                                           |
| --------------------- | --------------------------------------------------------------------- |
| `task` / `task apply` | Apply chezmoi changes, sync npm config, and install skills            |
| `task init`           | Run initial setup (edit config, install dependencies, and apply)      |
| `task os:ut`          | Upgrade system packages (Brew) and proto toolchains                   |
| `task os:clean`       | Clean package caches (Brew / Scoop, proto, pnpm)                      |
| `task nixos:routine`  | _(NixOS only)_ Update Nix channels, collect garbage, and rebuild      |
| `task fmt`            | Format config files with `dprint`                                     |
| `task ocf`            | Open the chezmoi configuration file in `$EDITOR`                      |

---

## Repository Layout

- `home/`: Managed configuration files and templates applied to `$HOME`
- `configs/`: System package manifests and dump scripts (such as Brewfile)
- `nixos/`: NixOS flake configuration and tasks
- `taskfile.yml`: Root automation task definitions
