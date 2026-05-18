return {
    src = "https://github.com/stevearc/oil.nvim",
    deps = { "https://github.com/nvim-tree/nvim-web-devicons" },
    setup = function()
        require("oil").setup({
            -- Don't prompt for simple operations like rename
            skip_confirm_for_simple_edits = true,
            view_options = {
                -- Show hidden files
                show_hidden = true,
            },
            columns = {
                "mtime",
                "icon",
            }
        })
    end,
}
