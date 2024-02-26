local function configureScala()
  require('lspconfig').metals.setup('force', {}, {
    settings = {
      ['metals'] = {},
    },
  })
end

return {
  name = 'lang:scala:lsp',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureScala,
  enabled = function()
    return vim.fn.executable('metals') == 1
  end,
}
