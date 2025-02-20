local has_lsp = vim.fn.executable('typescript-language-server') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  require('lspconfig').ts_ls.setup({})
end

return {
  setup = function()
    setupLsp()
  end,
}
