#!/bin/bash

echo "Deleting existing symlinks and files/folders created by symlink.sh..."

TARGETS=(
    "$HOME/.vimrc"
    "$HOME/.tmux.conf"
    "$HOME/.config/nvim"
    "$HOME/.config/ghostty"
)

for target in "${TARGETS[@]}"; do
    if [ -L "$target" ]; then
        echo "Deleting symlink: $target"
        rm "$target"
    elif [ -d "$target" ]; then
        echo "Deleting directory: $target"
        rm -rf "$target"
    elif [ -f "$target" ]; then
        echo "Deleting file: $target"
        rm "$target"
    else
        echo "Target does not exist or is not a file, directory, or symlink: $target"
    fi
done

echo "Deletion process complete."
