local function configureNix()
  if vim.fn.executable('nil') ~= 1 then
    return
  end

  require('lspconfig').nil_ls.setup({})
end

return {
  name = 'lang:nix',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureNix,
}
