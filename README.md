# Pink Champagne's dotfiles

[Install chezmoi](https://www.chezmoi.io/install/).

Initialize chezmoi with this repo.

```shell
chezmoi init git@github.com:PinkChampagne17/dotfiles-chezmoi.git
```

Create chezmoi configuration file to define variables.

```shell
touch ~/.config/chezmoi/chezmoi.toml
$EDITOR ~/.config/chezmoi/chezmoi.toml
```

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
    work.email = ""
    work.name = ""
```

Apply it.

```shell
chezmoi apply -v
```
