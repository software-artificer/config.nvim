local function configureRust()
  require('lspconfig').rust_analyzer.setup({}, {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            'cargo',
            'clippy',
            '--workspace',
            '--message-format=json',
            '--all-targets',
            '--all-features',
          },
        },
      },
    },
  })
end

return {
  name = 'lang:rust:lsp',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureRust,
  cond = function()
    return vim.fn.executable('rust-analyzer') == 1
  end,
}
