function setupPlugin(opts)
  require('lualine').setup(opts)

  vim.opt.showmode = false
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SmiteshP/nvim-navic',
  },
  config = setupPlugin,
  opts = {
    options = {
      theme = 'codedark',
    },
    sections = {
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
        },
        'diagnostics',
      },
      lualine_c = {},
    },
    winbar = {
      lualine_b = {
        'filename',
      },
      lualine_c = {
        {
          function()
            return require('nvim-navic').get_location()
          end,
          cond = function()
            return require('nvim-navic').is_available()
          end,
        },
      },
    },
  },
}
