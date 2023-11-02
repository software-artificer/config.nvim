local function setupPlugin()
  require('lsp_signature').setup({
    floating_window = false,
    doc_lines = 0,
    hint_prefix = '󱃺 ',
    --select_signature_key = '' -- switch between multiple signatures for the same function name
  })
end

return {
  'ray-x/lsp_signature.nvim',
  tag = 'v0.2.0',
  config = setupPlugin,
}
