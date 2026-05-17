return {
    src = "https://github.com/folke/which-key.nvim",
    setup = function()
        require("which-key").setup({
            delay = 1000,
        })
    end,
}
