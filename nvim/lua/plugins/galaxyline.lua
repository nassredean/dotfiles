local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local icons = require("icons")

-- tokyonight
local colors = {
  bg = '#24283b',
  bg_dim = '#1f2335',
  bg_light = '#292e42',
  black = '#414868',
  white = '#c0caf5',
  gray = '#a9b1d6',
  red = '#f7768e',
  green = '#9ece6a',
  yellow = '#ffc777',
  blue = '#82aaff',
  purple = '#fca7ea',
  teal = '#4fd6be',
}

local function mode_alias(m)
  local alias = {
    n = 'NORMAL',
    i = 'INSERT',
    c = 'COMMAND',
    R = 'REPLACE',
    t = 'TERMINAL',
    [''] = 'V-BLOCK',
    V = 'V-LINE',
    v = 'VISUAL',
  }

  return alias[m] or ''
end

local function mode_color(m)
  local mode_colors = {
    normal =  colors.green,
    insert =  colors.blue,
    visual =  colors.purple,
    replace =  colors.red,
  }

  local mycolor = {
    n = mode_colors.normal,
    i = mode_colors.insert,
    c = mode_colors.replace,
    R = mode_colors.replace,
    t = mode_colors.insert,
    [''] = mode_colors.visual,
    V = mode_colors.visual,
    v = mode_colors.visual,
  }

  return mycolor[m] or colors.bg_light
end

-- disable for these file types
gl.short_line_list = { 'startify', 'nerdtree', 'term', 'fugitive', 'NvimTree' }

gl.section.left[1] = {
  ViMode = {
    icon = '',
    separator = "",
    separator_highlight = 'GalaxyViModeReverse',
    highlight = {colors.bg, mode_color()},
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color(m)
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. color)
      return ' ' .. mode .. ' '
    end,
  }
}

gl.section.left[2] = {
  CWD = {
    -- separator = '  ',
    separator = "",
    separator_highlight = function()
      return {colors.bg_light, condition.buffer_not_empty() and colors.bg_dim or colors.bg}
    end,
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return icons.folderNoBg .. dirname .. ' '
    end,
  }
}


gl.section.left[3] = {
  FileIcon = {
    provider = function()
      local file_icon = require('galaxyline.provider_fileinfo').get_file_icon()
      return ' ' .. file_icon -- Adding a space before icon
    end,
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
  }
}

gl.section.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
    separator_highlight = {colors.bg_dim, colors.bg},
    separator = "",
  }
}

gl.section.left[5] = {
  DiffAdd = {
    icon = '  ',
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    highlight = {colors.white, colors.bg},
  }
}

gl.section.left[6] = {
  DiffModified = {
    icon = '  ',
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[7] = {
  DiffRemove = {
    icon = '  ',
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.right[1] = {
  FileType = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      local buf = require('galaxyline.provider_buffer')
      return string.lower(buf.get_buffer_filetype())
    end,
  }
}

gl.section.right[2] = {
  GitBranch = {
    icon = icons.git,
    separator = '  ',
    condition = condition.check_git_workspace,
    highlight = {colors.teal, colors.bg},
    provider = 'GitBranch',
  }
}

gl.section.right[3] = {
  FileLocation = {
    icon = ' ',
    separator = ' ',
    separator_highlight = {colors.bg_dim, colors.bg},
    highlight = {colors.gray, colors.bg_dim},
    provider = function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      if current_line == 1 then
        return 'Top'
      elseif current_line == total_lines then
        return 'Bot'
      end

      local percent, _ = math.modf((current_line / total_lines) * 100)
      return '' .. percent .. '%'
    end,
  }
}

vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_light)

