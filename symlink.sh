#!/bin/bash

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symlinks
ln -sfv "$DIR/.vimrc" "$HOME/.vimrc"
ln -sfv "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sfv "$DIR/.config/nvim" "$HOME/.config/nvim"
ln -sfv "$DIR/.config/ghostty" "$HOME/.config/ghostty"

echo "Done."
