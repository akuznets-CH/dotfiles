return {
    -- Mason: LSP installer
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup()
        end,
    },

    -- nvim-lspconfig: LSP client
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim" },
    },

    -- mason-lspconfig: Bridges Mason and nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "dockerls",
                    "gopls",
                    "pyright",
                    "sqlls",
                    "yamlls",
                    "ts_ls",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "jsonls",
                    "terraformls"
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
            })
        end,
    },
}
