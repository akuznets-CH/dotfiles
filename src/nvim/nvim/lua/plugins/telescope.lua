return {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    deps = { "https://github.com/nvim-lua/plenary.nvim" },
    setup = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = {
                        ".git/",
                        ".vscode/",
                        "node_modules/",
                        "__pycache__/",
                        ".venv/",
                        "venv/",
                        ".mypy_cache/",
                        ".pytest_cache/",
                        ".ipynb_checkpoints/",
                        "build/",
                        "target/",
                        "cmake-build-debug/",
                        "bin/",
                        "obj/",
                        "*.o",
                        "*.d",
                        "*.a",
                        "*.so",
                        "*.dll",
                        "*.lib",
                        "*.exe",
                        "dist/",
                        "out/",
                        ".parcel-cache/",
                        ".next/",
                        ".yarn/",
                        "pnpm-lock.yaml",
                        "htmlcov/",
                    },
                },
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                },
            },
        })
    end,
}
