return {
  'smjonas/inc-rename.nvim',
  opts = {},
  keys = {
    {
      '<leader>c',
      function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
      end,
      mode = 'n',
      desc = '󰟵 LSP: rename symbol',
      expr = true,
    },
  },
  config = function(self, opts)
    vim.opt.inccommand = 'split'

    require('inc_rename').setup(opts)
  end,
}
