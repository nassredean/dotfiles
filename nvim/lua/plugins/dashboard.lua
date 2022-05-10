local icons = require('icons')

vim.g.indentLine_fileTypeExclude = {"dashboard"}
vim.g.dashboard_custom_header = {
    "            ",
    "    ╓╓╓╓    ",
    "   ┌╨╨╨╨┐   ",
    "   │    ├┐  ",
    "   │$ $ └│  ",
    "   │ <  └┘  ",
    "   │    │   ",
    "   │┼─┼ │   ",
    "   │    │   ",
    "   └──┘ │   ",
    "     │  │   ",
    "     │  │   "
}
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
    a = {description = {icons.fileNoBg .. "Find File          "}, command = "Telescope find_files hidden=true"},
    b = {description = {icons.t .. "Find Word          "}, command = "Telescope live_grep"},
    d = {description = {icons.timer .. "Load Last Session  "}, command = "SessionLoad"},
    h = {description = {icons.container .. "Exit               "}, command = "exit"}
}
vim.g.dashboard_custom_footer = {"λ mind is software λ"}
