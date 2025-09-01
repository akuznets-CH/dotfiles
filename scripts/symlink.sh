#!/bin/bash

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Creating symlinks from $DIR to $HOME..."

# Create symlinks
echo "Creating symlink for .vimrc..."
ln -sfv "$DIR/.vimrc" "$HOME/.vimrc"

echo "Creating symlink for .tmux.conf..."
ln -sfv "$DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "Creating symlink for .config/nvim..."
ln -sfnv "$DIR/.config/nvim" "$HOME/.config/nvim"

echo "Creating symlink for .config/ghostty..."
ln -sfnv "$DIR/.config/ghostty" "$HOME/.config/ghostty"

echo "All symlinks created successfully."
