local function configureNix()
  require('lspconfig').nil_ls.setup({})
end

return {
  name = 'lang:nix:lsp',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureNix,
  enabled = function()
    return vim.fn.executable('nil') == 1
  end,
}
