return {
    src = "https://github.com/neovim/nvim-lspconfig",
    setup = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp.completion", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client:supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                end
            end,
        })

        local servers = {
            "gopls",
            "lua_ls",
            "ocamllsp",
            "rust_analyzer",
            "ty",
            "vtsls",
        }

        -- Keep this config portable across machines with different server sets installed.
        local available = {}
        for _, name in ipairs(servers) do
            local config = vim.lsp.config[name]
            local cmd = config and config.cmd
            if type(cmd) == "function" or (type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1) then
                available[#available + 1] = name
            end
        end

        if #available > 0 then vim.lsp.enable(available) end
    end,
}
