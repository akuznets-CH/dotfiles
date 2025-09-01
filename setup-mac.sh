#!/bin/bash

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew is already installed."
    fi
}

install_homebrew

echo "Installing nvim, ghostty, and tmux..."
brew install nvim tmux
brew install --cask ghostty

echo "Installation complete."
