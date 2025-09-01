return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
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
            },
        })
    end,
}
