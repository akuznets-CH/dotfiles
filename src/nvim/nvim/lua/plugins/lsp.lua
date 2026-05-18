return {
    src = "https://github.com/williamboman/mason-lspconfig.nvim",
    deps = {
        "https://github.com/williamboman/mason.nvim",
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
    setup = function()
        require("mason").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        })
    end,
}
