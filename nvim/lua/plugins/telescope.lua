local actions = require "telescope.actions"

require("telescope").setup(
    {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        layout_config = {
            horizontal = {
                preview_cutoff = 120
            },
            prompt_position = "top"
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " 🔍 ",
        color_devicons = true,
        sorting_strategy = "ascending",
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.send_selected_to_qflist,
                ["<C-s>"] = actions.cycle_previewers_next,
                ["<C-a>"] = actions.cycle_previewers_prev,
                ["<C-h>"] = "which_key"
            },
            n = {
                ["<C-s>"] = actions.cycle_previewers_next,
                ["<C-a>"] = actions.cycle_previewers_prev
            }
        }
    }
)
