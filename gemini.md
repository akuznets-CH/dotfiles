This repository manages personal dotfiles for a macOS development environment, configuring various tools and applications. While currently focused on Neovim, tmux, and Ghostty, the architecture is designed to be extensible for future configurations.

**Key Tools and Applications Configured (Current Focus):**
*   **Neovim (nvim):** The primary text editor, configured extensively using Lua. It leverages `lazy.nvim` for plugin management and integrates various tools like Language Server Protocol (LSP) via `mason.nvim` (LSP installer) and `nvim-lspconfig` (LSP client), `telescope.nvim` for fuzzy finding, `gitsigns.nvim` and `vim-fugitive` for Git integration, `Copilot` for AI assistance (`copilot.lua`, `copilot-cmp`, `CopilotChat.nvim`), `diffview.nvim` for Git diffs, `lualine.nvim` for status lines, `render-markdown.nvim` for markdown rendering, `rose-pine` for theming, `nvim-tree.lua` for file exploration, `nvim-treesitter` for syntax highlighting and parsing, and `which-key.nvim` for keybinding hints. Keymaps are defined in `lua/config/keymaps.lua`, general options in `lua/config/options.lua`, autocommands in `lua/config/auto-commands.lua`, and user-defined commands in `lua/config/user-commands.lua`. The `lazy-lock.json` file tracks plugin versions.
    *   **GitHub Repo:** [neovim/neovim](https://github.com/neovim/neovim)
*   **tmux:** A terminal multiplexer, configured with a `C-Space` prefix and custom keybindings for pane navigation (`C-Space h/j/k/l`).
    *   **GitHub Repo:** [tmux/tmux](https://github.com/tmux/tmux)
*   **Ghostty:** A terminal emulator, with basic theme configuration using `rose-pine`.
    *   **GitHub Repo:** [ghostty-org/ghostty](https://github.com/ghostty-org/ghostty)
*   **Vim:** A basic `.vimrc` is included for compatibility or fallback scenarios, defining leader keys, common options, keymaps for terminal exit and window navigation, and autocommands for clipboard sync and search highlighting.

**Configuration Management Strategy:

**Important Note on External Project Information:**
Before starting a task that might depend on up-to-date information about one of the listed projects (Neovim, tmux, Ghostty, etc.), you should navigate to the GitHub README for that project and find the information you need from there. If you ever encounter a dead link in this `gemini.md` file, you must either find an up-to-date replacement, or remove the link if no replacement exists.**
The core of this dotfiles setup relies on **symlinking**. Source configuration files and directories within this repository are symlinked to their appropriate locations in the user's home directory (`$HOME`). This strategy ensures that all configurations are version-controlled and easily deployable.

*   **Deployment:** The `scripts/symlink.sh` script is responsible for creating these symbolic links.
*   **Cleanup:** The `scripts/delete_symlinks.sh` script removes existing symlinks and associated directories/files, ensuring a clean state before re-deployment.
*   **Automation:** `Makefile`s are used to automate common tasks across the repository:
    *   The root `Makefile` orchestrates the main setup process (`make setup-mac`), which includes deleting old symlinks, installing dependencies via Homebrew, and creating new symlinks.
    *   Specific configuration directories, such as `.config/nvim/`, contain their own `Makefile`s for tasks relevant to that particular tool (e.g., `make lint` for linting and `make format` for formatting Neovim's Lua configuration files, installing Neovim-specific dependencies).

**Setup and Installation:**
*   The `scripts/brew-install.sh` script handles the installation of core tools (e.g., `nvim`, `tmux`, `ghostty`) using Homebrew, including a check for Homebrew's presence.
*   The `make setup-mac` command in the root `Makefile` provides a comprehensive one-step process to set up the environment from scratch.

**General Approach for Making Changes:**
1.  **Modify Source Files:** All changes should be made directly to the source configuration files located within this repository (e.g., `dotfiles/.config/nvim/lua/config/keymaps.lua`).
2.  **Re-deploy Symlinks:** After making changes, run `make symlink` from the repository root to update the symlinked files in your home directory. For a full refresh, `make setup-mac` can be used.
3.  **Maintain Code Quality:** For any configuration files or scripts in this repository, adhere to established coding standards and practices. Where applicable, utilize available tooling (e.g., linters, formatters) to ensure code style and quality. For Neovim Lua configurations, specifically, `make format` and `make lint` within the `.config/nvim/` directory are available.

**Important Considerations for this Document (`gemini.md`):**
This `gemini.md` file is a living document that describes the architecture and conventions of this dotfiles repository.
*   **Evolution with the Codebase:** As the codebase evolves and new tools or configurations are added, this document should be updated to reflect those changes. Consider whether architectural shifts necessitate a rethinking of the described strategies.
*   **Accuracy and Relevance:** For any change you make to the codebase, you should ask yourself if that change invalidates anything stated in the `readme.md` or `gemini.md` files. If it does, you must update the relevant documentation accordingly to maintain accuracy and relevance.
