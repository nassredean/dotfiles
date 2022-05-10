local icons = require("icons")

require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and icons.error or icons.warningTriangle
            return " " .. icon .. count
        end,
        numbers = "ordinal",
        offsets = {
            filetype = "NvimTree",
            text = function()
                return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left"
        }
    }
}
