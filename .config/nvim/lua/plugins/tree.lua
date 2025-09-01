return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Already listed as a lualine dep, but good to have it explicit here
    config = function()
        require("nvim-tree").setup({})
    end,
}
