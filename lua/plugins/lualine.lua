return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/tokyonight.nvim',
    'SmiteshP/nvim-navic',
  },
  opts = {
    theme = 'tokyonight',
    refresh = {
      refresh_time = 32,
    },
    sections = {
      lualine_b = {
        { 'branch', icon = '' },
        {
          'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
        },
        {
          'diagnostics',
          symbols = {
            error = '󰅝',
            warn = '',
            info = '',
            hint = '󰌶',
          },
        },
      },
      -- Do not display filename in the status line
      lualine_c = {},
    },
    winbar = {
      lualine_b = {
        {
          'filename',
          symbols = {
            modified = '',
            readonly = '',
          },
        },
      },
      lualine_c = {
        {
          function()
            return require('nvim-navic').get_location()
          end,
          cond = function()
            return require('nvim-navic').is_available()
          end,
        }
      },
    },
  },
}
