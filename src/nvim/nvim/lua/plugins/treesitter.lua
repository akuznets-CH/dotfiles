return {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    build = function(event)
        if event.data.kind == "update" then
            pcall(vim.cmd, "TSUpdate")
        end
    end,
    setup = function()
        local ts = require("nvim-treesitter")

        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        ts.install({
            "bash",
            "comment",
            "jsdoc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
        })

        local function enable(buf, lang)
            pcall(vim.treesitter.start, buf, lang)
        end

        local installed = {}
        for _, p in ipairs(ts.get_installed("parsers")) do installed[p] = true end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match
                if not lang or lang == "" then return end

                if installed[lang] then
                    enable(args.buf, lang)
                    return
                end

                if not require("nvim-treesitter.parsers")[lang] then return end

                ts.install({ lang }):await(vim.schedule_wrap(function()
                    installed[lang] = true
                    enable(args.buf, lang)
                end))
            end,
        })
    end,
}
