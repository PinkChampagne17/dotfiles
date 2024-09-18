# Pink Champagne's dotfiles

## Install the dependencies
- [chezmoi](https://www.chezmoi.io/install/)
- [Task](https://taskfile.dev/installation) (or manually  run the commands from the taskfiles)

## Add the SSH key to GitHub settings.
1. [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) (Optional)
2. [Add the SSH key to GitHub settings](https://github.com/settings/keys)

## Initialize chezmoi with this repo and apply
```
chezmoi init git@github.com:PinkChampagne17/dotfiles.git
task init
```
