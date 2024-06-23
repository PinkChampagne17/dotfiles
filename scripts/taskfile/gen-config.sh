#!/bin/sh

DESTINATION_PATH="$HOME/.config/chezmoi/chezmoi.toml"

if [ ! -f "$DESTINATION_PATH" ]; then
    cp ./templates/chezmoi.toml "$DESTINATION_PATH"
fi

$EDITOR $DESTINATION_PATH
