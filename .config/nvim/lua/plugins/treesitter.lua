return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "typescript",
                "rust",
                "go",
                "python",
                "html",
                "bash",
                "css",
                "dockerfile",
                "json",
                "markdown",
                "sql",
                "toml",
                "yaml",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
        })
    end,
}
