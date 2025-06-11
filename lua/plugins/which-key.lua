return {
  'folke/which-key.nvim',
  version = '^3.17',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  lazy = false,
  opts = {
    preset = 'classic',
    delay = 800,
    win = { no_overlap = true },
    spec = {
      {
        '<leader>y',
        '"+y',
        mode = { 'n', 'v' },
        desc = 'Yank to system clipboard',
        icon = { icon = '󰱗', color = 'yellow' },
        noremap = false,
      },
      {
        '<leader>d',
        '"+d',
        mode = { 'n', 'v' },
        desc = 'Cut to system clipboard',
        icon = { icon = '', color = 'yellow' },
        noremap = false,
      },
      {
        '<leader>?',
        function()
          require('which-key').show()
        end,
        mode = { 'n', 'v' },
        desc = 'Show keymaps',
        icon = { icon = '󰡾', color = 'yellow' },
      },
    },
  },
}
