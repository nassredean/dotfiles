local keymap = vim.keymap.set
local silent = { silent = true }

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

-- Keep visual mode indenting
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- Save file by CTRL-S
keymap("n", "<C-s>", ":w<CR>", silent)
keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Telescope
keymap("n", "<Leader>t", "<CMD>lua require('telescope.builtin').find_files()<CR>")
keymap("n", "<Leader>a", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
keymap("n", "<Leader>b", "<CMD>lua require('telescope.builtin').buffers()<CR>")
keymap("n", "<Leader>s", "<CMD>lua require('telescope.builtin').search_history()<CR>")
keymap("n", "<Leader>r", "<CMD>lua require('telescope.builtin').command_history()<CR>")
keymap("n", "<Leader>y", "<CMD>lua require('telescope.builtin').registers()<CR>")
-- Telescope - LSP
keymap("n", "<Leader>lr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>")
keymap("n", "<Leader>ld", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>")
keymap("n", "<Leader>lm", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>")
keymap("n", "<Leader>lt", "<CMD>lua require('telescope.builtin').diagnostics({ bufnr=0 })<CR>")
-- Telescope - Git
keymap("n", "<Leader>gc", "<CMD>lua require('telescope.builtin').git_commits()<CR>")
keymap("n", "<Leader>gb", "<CMD>lua require('telescope.builtin').git_bcommits()<CR>")
keymap("n", "<Leader>gs", "<CMD>lua require('telescope.builtin').git_status()<CR>")
keymap("n", "<Leader>gr", "<CMD>lua require('telescope.builtin').git_branches()<CR>")

-- Git
keymap("n", "<Leader>g", ":Gitsigns blame<CR>", silent)

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", silent)
keymap("n", "<Leader>r", ":NvimTreeRefresh<CR>", silent)
keymap("n", "<Leader>n", ":NvimTreeFindFile<CR>", silent)

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", silent)

-- Buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", silent)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Trigger completion window
keymap("i", "<C-Space>", "<C-x><C-o>", silent)

-- Fix stupid search behavior
keymap("n", "n", "/<CR>")
keymap("n", "N", "?<CR>")

-- Remap space to : in normal mode
keymap("n", "<Space>", ": ", silent)

--- need session load behavior back
-- keymap("n", "<Leader>ss", ":SessionSave<CR>", silent)
-- keymap("n", "<Leader>sl", ":SessionLoad<CR>", silent)

-- Treewalker
-- movement (Alt/Option + key)
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<cmd>Treewalker Right<cr>', { silent = true })

-- swapping (Alt/Option + Shift + key)
vim.keymap.set('n', '<A-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<A-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
vim.keymap.set('n', '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true })

