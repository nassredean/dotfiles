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
-- keymap("n", "<Leader>h", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

-- Git
keymap("n", "<Leader>g", ":Git blame<CR>", silent)

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", silent)
keymap("n", "<Leader>r", ":NvimTreeRefresh<CR>", silent)
-- keymap("n", "<Leader>n", ":NvimTreeFindFile<CR>", silent)

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

