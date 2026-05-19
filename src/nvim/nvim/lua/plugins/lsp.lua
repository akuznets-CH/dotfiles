return {
    src = "https://github.com/neovim/nvim-lspconfig",
    setup = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client:supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                end
            end,
        })

        local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
        if vim.fn.isdirectory(lsp_dir) ~= 1 then return end

        for _, path in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
            local name = vim.fn.fnamemodify(path, ":t:r")
            local cfg = vim.lsp.config[name]
            local cmd = cfg and cfg.cmd
            local bin = (type(cmd) == "table" and cmd[1])
                     or (type(cmd) == "string" and cmd)
                     or nil
            if not bin or vim.fn.executable(bin) == 1 then
                vim.lsp.enable(name)
            end
        end
    end,
}
