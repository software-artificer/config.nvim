local function configureRust()
  if vim.fn.executable('rust-analyzer') ~= 1 then
    return
  end

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
  name = 'lang:rust',
  depends = { 'lang:common', 'neovim/nvim-lspconfig' },
  dir = '.',
  config = configureRust,
}
