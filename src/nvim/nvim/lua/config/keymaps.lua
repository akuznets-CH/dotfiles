    local keymap = vim.keymap.set

-- Clipboard
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Use <Esc> to exit terminal mode
keymap("t", "<Esc>", function()
    local win_id = vim.api.nvim_get_current_win()
    local win_config = vim.api.nvim_win_get_config(win_id)
    if win_config.relative == "editor" and vim.bo.buftype == "terminal" then
        vim.api.nvim_win_close(win_id, true)
    else
        -- Fallback to default behavior for non-floating terminals or other buffers
        vim.api.nvim_input([[\<C-\\><C-n>]])
    end
end, { desc = "Exit terminal mode or close floating terminal" })

-- Navigate between panes with ctrl + h/j/k/l
keymap({ "n" }, "<C-h>", "<C-w>h")
keymap({ "n" }, "<C-j>", "<C-w>j")
keymap({ "n" }, "<C-k>", "<C-w>k")
keymap({ "n" }, "<C-l>", "<C-w>l")

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Search word under cursor" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Search commands" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fm", "<cmd>Telescope git_status<cr>", { desc = "Find git modified files" })
keymap("n", "<leader>xx", "<cmd>Telescope diagnostics<cr>", { desc = "Show workspace diagnostics" })
keymap("n", "<leader>wk", "<cmd>WhichKey<cr>", { desc = "Which key" })

-- NvimTree
keymap("n", "<leader>o", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
keymap("n", "<leader>i", "<cmd>NvimTreeResize 50<cr>", { desc = "Reset file explorer width" })
keymap("n", "<leader>O", "<cmd>NvimTreeResize +20<cr>", { desc = "Increase file explorer width" })
keymap("n", "<leader>I", "<cmd>NvimTreeResize -20<cr>", { desc = "Decrease file explorer width" })

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

-- Gitsigns
keymap("n", "<leader>gss", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
keymap("n", "<leader>gsu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage hunk" })
keymap("n", "<leader>gsp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
keymap("n", "<leader>gsr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Preview hunk" })
keymap("n", "<leader>gsn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
keymap("n", "<leader>gsN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
keymap("n", "<leader>gsS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })

-- Terminal
local terminal_buf = nil
local terminal_win = nil

local function toggle_floating_terminal()
    local buf_exists = terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf)
    local win_exists = terminal_win and vim.api.nvim_win_is_valid(terminal_win)

    if win_exists then
        -- Window exists, toggle visibility
        local win_config = vim.api.nvim_win_get_config(terminal_win)
        if win_config.hidden then
            -- It's hidden, show it
            vim.api.nvim_win_set_config(terminal_win, { hidden = false })
            vim.api.nvim_set_current_win(terminal_win)
            vim.cmd("startinsert")
        else
            -- It's visible, hide it
            vim.api.nvim_win_set_config(terminal_win, { hidden = true })
        end
    elseif buf_exists then
        -- Buffer exists, but window doesn't. Re-open window for existing buffer.
        terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
            relative = "editor",
            row = math.floor(vim.o.lines * 0.1),
            col = math.floor(vim.o.columns * 0.1),
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            border = "single",
            style = "minimal",
        })
        vim.api.nvim_set_current_win(terminal_win)
        vim.cmd("startinsert")
    else
        -- Neither buffer nor window exists, create new
        terminal_buf = vim.api.nvim_create_buf(true, false)
        terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
            relative = "editor",
            row = math.floor(vim.o.lines * 0.1),
            col = math.floor(vim.o.columns * 0.1),
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            border = "single",
            style = "minimal",
        })
        vim.api.nvim_set_current_win(terminal_win)
        vim.cmd("terminal")
        vim.cmd("startinsert")
    end
end

keymap("n", "<leader>ft", toggle_floating_terminal, { desc = "Toggle floating terminal" })
