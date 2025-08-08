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
        mode = { 'n', 'v', 'x' },
        desc = 'Yank to the system clipboard',
        icon = { icon = '󰱗', color = 'yellow' },
        noremap = false,
      },
      {
        '<leader>Y',
        '"+Y',
        mode = { 'n', 'v', 'x' },
        desc = 'Yank [count] lines to the system clipboard',
        icon = { icon = '󰱗', color = 'yellow' },
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
      {
        'gd',
        function() vim.lsp.buf.definition() end,
        mode = 'n',
        desc = 'Go to definition',
        icon = { icon = '', color = 'orange' },
      },
      {
        'gD',
        function() vim.lsp.buf.declaration() end,
        mode = 'n',
        desc = 'Go to declaration',
        icon = { icon = '', color = 'orange' },
      },
      {
        '<leader>fS',
        function() vim.lsp.buf.workspace_symbol() end,
        mode = 'n',
        desc = '[F]ind workspace [s]ymbols',
        icon = { icon = '󱊓', color = 'orange' },
      },
      {
        '<leader>lcr',
        function() vim.lsp.codelens.run() end,
        mode = 'n',
        desc = 'Run the [L]SP [c]odelens',
        icon = { icon = '󱖪', color = 'orange' },
      },
      {
        '<leader>lf',
        function() vim.lsp.buf.format() end,
        mode = 'n',
        desc = '[L]SP [f]ormat the document',
        icon = { icon = '', color = 'orange' },
      },
    },
  },
}
