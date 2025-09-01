local keymap = vim.keymap.set

-- Use <Esc> to exit terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Navigate between panes with leader + h/j/k/l
keymap({ "n" }, "<leader>h", "<C-w>h")
keymap({ "n" }, "<leader>j", "<C-w>j")
keymap({ "n" }, "<leader>k", "<C-w>k")
keymap({ "n" }, "<leader>l", "<C-w>l")

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- NvimTree
keymap("n", "<leader>o", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- LSP
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature help" })
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })
keymap("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

-- Copilot Chat
keymap("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })
keymap("n", "<leader>cr", "<cmd>CopilotChatReset<cr>", { desc = "Reset Copilot Chat" })
keymap("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
keymap("v", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "CopilotChat - Generate tests" })

-- Gitsigns
keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
keymap("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage hunk" })
keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
keymap("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
keymap("n", "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
keymap("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })

-- Terminal
keymap("n", "<leader>ft", function()
    vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(false, true))
    vim.api.nvim_open_win(vim.api.nvim_get_current_buf(), true, {
        relative = "editor",
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        border = "single",
        style = "minimal",
    })
    vim.cmd("startinsert")
    vim.cmd("terminal")
end, { desc = "Open floating terminal" })

-- Diffview
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })

-- Fugitive
keymap("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Open Git status" })
