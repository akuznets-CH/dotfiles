return {
    src = "https://github.com/nvim-lualine/lualine.nvim",
    deps = { "https://github.com/nvim-tree/nvim-web-devicons" },
    setup = function()
        require("lualine").setup({
            options = {
                theme = "auto",
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
        })
    end,
}
