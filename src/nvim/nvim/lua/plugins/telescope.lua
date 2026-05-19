return {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    deps = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
    },
    setup = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = { ".git/" },
                },
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                },
            },
        })
    end,
}
