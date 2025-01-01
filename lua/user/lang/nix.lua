local has_lsp = vim.fn.executable('nil') == 1

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    if has_lsp then
      require('lspconfig').nil_ls.setup({})
    end
  end,
}
