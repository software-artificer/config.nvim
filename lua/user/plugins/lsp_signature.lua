local function setupPlugin()
  require('lsp_signature').setup({
    floating_window = false,
    doc_lines = 0,
  })
end

return {
  'ray-x/lsp_signature.nvim',
  tag = 'v0.2.0',
  config = setupPlugin,
}
