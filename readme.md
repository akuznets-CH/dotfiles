## First-Time Setup

Run the following command in the root of this repository:

```bash
make setup-mac
```

This will:
1.  Delete any existing symlinks or files that would conflict with the dotfiles.
2.  Install homebrew, neovim, tmux, and ghostty.
3.  Create symlinks in the home directory.

## GitHub Copilot Authentication

1.  Open Neovim:
    ```bash
    nvim
    ```
2.  Once Neovim is open, run the following command:
    ```
    :Copilot auth
    ```
    This will open a browser window to authenticate with GitHub.
