local function configureScala()
  if vim.fn.executable('metals') ~= 1 then
    return
  end

  require('lspconfig').metals.setup('force', {}, {
    settings = {
      ['metals'] = {},
    },
  })
end

return {
  name = 'lang:scala',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureScala,
}
