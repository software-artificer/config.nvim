local has_lsp = vim.fn.executable('vscode-json-language-server') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require('lspconfig').jsonls.setup({
    capabilities = capabilities,
  })
end

return {
  setup = function()
    setupLsp()
  end,
}
