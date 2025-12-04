return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                -- Use ruff_fix to organize imports and fix lint errors
                -- Use ruff_format to format code (like Black)
                python = { "ruff_fix", "ruff_format" },
            },
            format_on_save = {
                -- These options ensure it doesn't timeout on large files
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        })
    end,
}
