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
        vim.api.nvim_echo(
          { { '󰉼 LSP formatting toggled', 'WarningMsg' } },
          false,
          {}
        )
      end,
      mode = { 'n' },
      desc = 'Toggle automatic LSP formatting',
    },
  },
}
