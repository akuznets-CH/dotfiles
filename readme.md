# Dotfiles Setup Guide

This repository contains my personal dotfiles for various tools and configurations, including Neovim, Tmux, and Ghostty.

## First-Time Setup

To set up these dotfiles on a new macOS system, you can use the provided `Makefile`. This will:
1.  Delete any existing symlinks or files that would conflict with the dotfiles.
2.  Install Homebrew (if not already installed), Neovim, Tmux, and Ghostty.
3.  Create symbolic links for the dotfiles in your home directory.

Run the following command in the root of this repository:

```bash
make setup-mac
```

## Neovim Plugin Installation

Neovim plugins are managed by `lazy.nvim`. After running `make setup-mac` and launching Neovim for the first time, `lazy.nvim` will automatically install all the necessary plugins.

## GitHub Copilot Authentication

For GitHub Copilot to function correctly within Neovim, you need to authenticate it.

1.  Open Neovim:
    ```bash
    nvim
    ```
2.  Once Neovim is open, run the following command:
    ```
    :Copilot auth
    ```
    This will open a browser window to authenticate with your GitHub account. Follow the prompts to complete the authentication process.
