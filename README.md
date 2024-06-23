# Pink Champagne's dotfiles

## Install the dependencies

- [chezmoi](https://www.chezmoi.io/install/)
- [Task](https://taskfile.dev/installation) (or manually  run the commands from the taskfiles)

Initialize chezmoi with this repo.

```
chezmoi init git@github.com:PinkChampagne17/dotfiles.git
```

## Create chezmoi configuration file and define variables.
```
task gen-config
```

## Apply
```
task
# or
task default
```
