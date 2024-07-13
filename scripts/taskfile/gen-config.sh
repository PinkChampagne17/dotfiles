#!/bin/sh

DESTINATION_DIR="$HOME/.config/chezmoi"
DESTINATION_PATH="$DESTINATION_DIR/chezmoi.toml"

if [ ! -f "$DESTINATION_PATH" ]; then
    mkdir -p "$DESTINATION_DIR" &&
    cp -r ./templates/chezmoi.toml "$DESTINATION_PATH"
fi

$EDITOR $DESTINATION_PATH
