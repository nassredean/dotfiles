-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.opt.list = true

require("ibl").setup {
  buftype_exclude = {"terminal", "telescope", "nofile"},
  filetype_exclude = {"help", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float"},
  show_end_of_line = false,
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  use_treesitter = false,
}
