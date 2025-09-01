return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        opts = {
            model = "gpt-5",
            temperature = 0.8,
            window = {
                layout = "float",
                width = 0.75,
                height=0.75,
            },
            auto_insert_mode = false,
        },
    },
}
