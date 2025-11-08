## First-Time Setup

Run the following command in the root of this repository:
```bash
make setup-mac
```

This will:
1.  Delete any existing symlinks or files that would conflict with the dotfiles.
2.  Install homebrew, neovim, tmux, ghostty, and other packages.
3.  Create symlinks to dotfiles.

## GitHub Copilot Authentication
2.  In Neovim, run:
    ```
    :Copilot auth
    ```
