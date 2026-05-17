-- Central loader for vim.pack-managed plugins.
--
-- Each module under `lua/plugins/` returns a table:
--   {
--     src     = "https://github.com/owner/repo",  -- required
--     name    = "override",                        -- optional
--     version = "branch|tag|commit",               -- optional
--     deps    = { "url", { src = "url", ... } },   -- optional
--     setup   = function() ... end,                -- optional
--     build   = function(event) ... end,           -- optional, PackChanged
--   }
--
-- Order matters: vim.pack has no dependency resolution and `setup` runs
-- immediately. Plugins listed later may depend on earlier ones being loaded.

local order = {
    "rose-pine",
    "web-devicons",
    "lualine",
    "oil",
    "telescope",
    "treesitter",
    "lsp",
    "cmp",
    "gitsigns",
    "fugitive",
    "which-key",
}

local modules = {}
for _, name in ipairs(order) do
    modules[#modules + 1] = { name = name, mod = require("plugins." .. name) }
end

local function spec_of(entry)
    if type(entry) == "string" then return { src = entry } end
    return { src = entry.src, name = entry.name, version = entry.version }
end

local specs = {}
local seen = {}
local function push(entry)
    local s = spec_of(entry)
    if seen[s.src] then return end
    seen[s.src] = true
    specs[#specs + 1] = s
end

for _, m in ipairs(modules) do
    for _, dep in ipairs(m.mod.deps or {}) do push(dep) end
    push(m.mod)
end

local build_hooks = {}
for _, m in ipairs(modules) do
    if m.mod.build then
        local hook_name = m.mod.name or m.mod.src:match("([^/]+)$")
        build_hooks[hook_name] = m.mod.build
    end
end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
        local hook = build_hooks[event.data.spec.name]
        if hook then hook(event) end
    end,
})

vim.pack.add(specs)

for _, m in ipairs(modules) do
    if m.mod.setup then m.mod.setup() end
end
