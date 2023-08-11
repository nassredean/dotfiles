-- Auto sync plugins on save of plugins.lua
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "plugins.lua", command = "source <afile> | PackerSync"})

-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", {pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)"})
vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)"})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {pattern = {"*.txt", "*.md", "*.tex"}, command = "setlocal spell"}
)

-- Save session on leave
vim.api.nvim_create_autocmd("VimLeave", {pattern = "*", command = ":SessionSave"})
