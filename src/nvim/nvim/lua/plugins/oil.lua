return {
    src = "https://github.com/stevearc/oil.nvim",
    deps = { "https://github.com/nvim-tree/nvim-web-devicons" },
    setup = function()
        require("oil").setup({
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
