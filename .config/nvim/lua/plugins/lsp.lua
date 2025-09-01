return {
    -- Mason: LSP installer
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- nvim-lspconfig: LSP client
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim" }, -- Mason is a dependency
    },

    -- mason-lspconfig: Bridges Mason and nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp", -- Add cmp-nvim-lsp as a dependency here for clarity
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "dockerls",
                    "docker_compose_language_service",
                    "gopls",
                    "marksman",
                    "pyright",
                    "rust_analyzer",
                    "sqlls",
                    "taplo",
                    "lemminx",
                    "yamlls",
                    "ts_ls",
                    "clangd",
                    "html",
                    "cssls",
                    "jsonls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
            })
        end,
    },
}
