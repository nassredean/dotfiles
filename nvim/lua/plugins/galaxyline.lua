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
    highlight = {colors.bg, mode_color()},
    icon = " " .. icons.vim,
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color(m)
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. color)
      return mode .. ' '
    end,
    separator = icons.leftSeparator,
    separator_highlight = 'GalaxyViModeReverse',
  }
}

gl.section.left[2] = {
  CWD = {
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return icons.folderNoBg .. dirname .. ' '
    end,
    separator = icons.leftSeparator,
    separator_highlight = function()
      return {colors.bg_light, condition.buffer_not_empty() and colors.bg_dim or colors.bg}
    end,
  }
}

gl.section.left[3] = {
  FileIcon = {
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
    provider = function()
      local file_icon = require('galaxyline.provider_fileinfo').get_file_icon()
      return ' ' .. file_icon -- Adding a space before icon
    end,
    separator_highlight = function()
      return {colors.bg_light, condition.buffer_not_empty() and colors.bg_light or colors.bg}
    end,
  }
}

gl.section.left[4] = {
  FileName = {
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
    provider = 'FileName',
    separator = icons.leftSeparator,
    separator_highlight = {colors.bg_dim, colors.bg_light},
  }
}

gl.section.left[5] = {
  LspIcon = {
    condition = condition.buffer_not_empty,
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local name = ""
      if gl.lspclient ~= nil then
        name = gl.lspclient()
      end
      return icons.gears .. ' ' .. name
    end,
  }
}

gl.section.left[6] = {
  ShowLspClient = {
    condition = condition.buffer_not_empty,
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local client = require('galaxyline.provider_lsp').get_lsp_client()
      return client .. ' ' -- Adding a space after the client name
    end,
    separator = icons.leftSeparator,
    separator_highlight = {colors.bg_light, colors.bg},
  }
}

gl.section.right[1] = {
  GitBranch = {
    condition = condition.check_git_workspace,
    highlight = {colors.teal, colors.bg_dim},
    icon = icons.git,
    provider = function()
      local client = require('galaxyline.provider_vcs').get_git_branch()
      if client then
        return client .. ' ' -- Append a space to the branch name
      else
        return '' -- Return an empty string if no branch name is found
      end
    end,
    separator = icons.rightSeparator,
    separator_highlight = {colors.bg_dim, colors.bg},
  }
}

gl.section.right[2] = {
  DiffAdd = {
    condition = condition.check_git_workspace,
    highlight = {colors.green, colors.bg_light},
    icon = icons.gitAdd,
    provider = 'DiffAdd',
    separator = icons.rightSeparator,
    separator_highlight = {colors.bg_light, colors.bg_dim},
  }
}

gl.section.right[3] = {
  DiffModified = {
    condition = condition.check_git_workspace,
    highlight = {colors.yellow, colors.bg_light},
    icon = icons.gitChange,
    provider = 'DiffModified',
  }
}

gl.section.right[4] = {
  DiffRemove = {
    condition = condition.check_git_workspace,
    highlight = {colors.red, colors.bg_light},
    icon = icons.gitRemove,
    provider = 'DiffRemove',
  }
}

gl.section.right[5] = {
  FileLocation = {
    highlight = {colors.gray, colors.bg_dim},
    icon = icons.fileLocation,
    provider = function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')
      if current_line == 1 then
        return 'Top '
      elseif current_line == total_lines then
        return 'Bot '
      end
      local percent, _ = math.modf((current_line / total_lines) * 100)
      return '' .. percent .. '% '
    end,
    separator = icons.rightSeparator,
    separator_highlight = {colors.bg_dim, colors.bg_light},
  }
}

vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_light)
