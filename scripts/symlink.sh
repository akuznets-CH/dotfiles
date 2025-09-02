#!/bin/bash

# Get the directory of this script's parent (the dotfiles root)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

# Create symlinks
ln -sfv "$DIR/.vimrc" "$HOME/.vimrc"
ln -sfv "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$DIR/.config/nvim" "$HOME/.config/nvim"
ln -sfnv "$DIR/.config/ghostty" "$HOME/.config/ghostty"
