-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
