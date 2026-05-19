return {
    src = "https://github.com/neovim/nvim-lspconfig",
    deps = { "https://github.com/hrsh7th/cmp-nvim-lsp" },
    setup = function()
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
