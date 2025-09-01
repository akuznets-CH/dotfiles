read_globals = {
  "vim",
  "require",
}
std = "lua51"
ignore = {
  "122", -- Setting a read-only field of a global variable (e.g., vim.g, vim.o)
  "631", -- Line is too long
}
