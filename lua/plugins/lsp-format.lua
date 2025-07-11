return {
  'lukas-reineke/lsp-format.nvim',
  version = '^2.7.2',
  opts = {
    sync = true,
  },
  keys = {
    {
      '<leader>ltf',
      function()
        require('lsp-format').toggle({ args = '' })
        vim.print('󰉼 LSP formatting toggled')
      end,
      mode = { 'n' },
      desc = 'Toggle automatic LSP formatting',
    },
  },
}
