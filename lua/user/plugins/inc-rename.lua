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
}
