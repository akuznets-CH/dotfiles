return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            -- Don't prompt for simple operations like rename
            skip_confirm_for_simple_edits = true,
            view_options = {
                -- Show hidden files
                show_hidden = true,
            },
        })
    end,
}
