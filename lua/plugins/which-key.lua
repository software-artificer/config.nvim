return {
  'folke/which-key.nvim',
  version = '^3.17',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  lazy = false,
  opts = {
    preset = 'classic',
    delay = 800,
    spec = {
      {
        '<leader>y',
        '"+y',
        mode = { 'n', 'v' },
        desc = 'Yank to system clipboard',
        icon = '󰱘',
        noremap = false,
      }, {
        '<leader>d',
        '"+d',
        mode = { 'n', 'v' },
        desc = 'Cut to system clipboard',
        icon = '󰆐',
        noremap = false,
      }
    },
  },
  keys = {
    {
      mode = { 'n', 'v' },
      '<leader>?',
      function()
        require('which-key').show()
      end,
      desc = 'Show keymaps',
    }
  }
}
