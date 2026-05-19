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
-- Modules are discovered by scanning `lua/plugins/`. setup() runs in
-- topological order (declared deps first; alphabetical tiebreak).

local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local modules = {}
for _, path in ipairs(vim.fn.glob(plugins_dir .. "/*.lua", false, true)) do
    local name = vim.fn.fnamemodify(path, ":t:r")
    modules[#modules + 1] = { name = name, mod = require("plugins." .. name) }
end
table.sort(modules, function(a, b) return a.name < b.name end)

local by_src = {}
for _, m in ipairs(modules) do by_src[m.mod.src] = m end

local sorted, visited, visiting = {}, {}, {}
local function visit(m)
    if visited[m.name] then return end
    if visiting[m.name] then
        error("circular plugin dependency at " .. m.name)
    end
    visiting[m.name] = true
    for _, dep in ipairs(m.mod.deps or {}) do
        local dep_src = type(dep) == "string" and dep or dep.src
        local dep_mod = by_src[dep_src]
        if dep_mod then visit(dep_mod) end
    end
    visiting[m.name] = nil
    visited[m.name] = true
    sorted[#sorted + 1] = m
end
for _, m in ipairs(modules) do visit(m) end

local function spec_of(entry)
    if type(entry) == "string" then return { src = entry } end
    return { src = entry.src, name = entry.name, version = entry.version }
end

local specs, seen = {}, {}
local function push(entry)
    local s = spec_of(entry)
    if seen[s.src] then return end
    seen[s.src] = true
    specs[#specs + 1] = s
end

for _, m in ipairs(sorted) do
    for _, dep in ipairs(m.mod.deps or {}) do push(dep) end
    push(m.mod)
end

local build_hooks = {}
for _, m in ipairs(sorted) do
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

for _, m in ipairs(sorted) do
    if m.mod.setup then m.mod.setup() end
end
