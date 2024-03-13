local function configureRust()
  require('lspconfig').rust_analyzer.setup({
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          command = 'clippy',
        },
      },
    },
  })
end

return {
  name = 'lang:rust:lsp',
  dependencies = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureRust,
  cond = function()
    return vim.fn.executable('rust-analyzer') == 1
  end,
}
