This repository manages personal dotfiles for a macOS development environment, primarily configuring Neovim, tmux, and Ghostty.

**Key Tools and Applications Configured:**
*   **Neovim (nvim):** The primary text editor, configured extensively using Lua. It leverages `lazy.nvim` for plugin management and integrates various tools like Language Server Protocol (LSP) via `mason.nvim` and `nvim-lspconfig`, `telescope.nvim` for fuzzy finding, `gitsigns.nvim` and `vim-fugitive` for Git integration, and `Copilot` for AI assistance.
*   **tmux:** A terminal multiplexer, configured with custom keybindings and a `C-Space` prefix.
*   **Ghostty:** A terminal emulator, with basic theme configuration.
*   **Vim:** A basic `.vimrc` is included for compatibility or fallback scenarios.

**Configuration Management Strategy:**
The core of this dotfiles setup relies on **symlinking**. Source configuration files and directories within this repository are symlinked to their appropriate locations in the user's home directory (`$HOME`).

*   **Deployment:** The `scripts/symlink.sh` script is responsible for creating these symbolic links.
*   **Cleanup:** The `scripts/delete_symlinks.sh` script removes existing symlinks and associated directories/files, ensuring a clean state before re-deployment.
*   **Automation:** `Makefile`s are used to automate common tasks:
    *   The root `Makefile` orchestrates the main setup process (`make setup-mac`), which includes deleting old symlinks, installing dependencies via Homebrew, and creating new symlinks.
    *   The `.config/nvim/Makefile` provides commands for linting (`make lint`) and formatting (`make format`) Neovim's Lua configuration files, and installing Neovim-specific dependencies.

**Setup and Installation:**
*   The `scripts/brew-install.sh` script handles the installation of `nvim`, `tmux`, and `ghostty` using Homebrew, including a check for Homebrew's presence.
*   The `make setup-mac` command in the root `Makefile` provides a comprehensive one-step process to set up the environment from scratch.

**General Approach for Making Changes:**
1.  **Modify Source Files:** All changes should be made directly to the source configuration files located within this repository (e.g., `dotfiles/.config/nvim/lua/config/keymaps.lua`).
2.  **Re-deploy Symlinks:** After making changes, run `make symlink` from the repository root to update the symlinked files in your home directory. For a full refresh, `make setup-mac` can be used.
3.  **Maintain Code Quality (Neovim):** For Neovim Lua configurations, utilize `make format` and `make lint` within the `.config/nvim/` directory to ensure code style and quality.

**Important:** For any change you make to the codebase, you should ask if that change invalidates anything stated in the `readme.md` or `gemini.md` files. If it does, you should update the file accordingly.