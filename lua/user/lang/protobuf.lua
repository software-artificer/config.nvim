local has_lsp = vim.fn.executable('buf') == 1
local has_linter = vim.fn.executable('protolint') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.semanticTokens = false

  require('lspconfig').buf_ls.setup({
    on_init = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })
end

local function setupLinter()
  if not has_linter then
    return
  end

  local none_ls = require('null-ls')
  none_ls.register(none_ls.builtins.diagnostics.protolint)
end

return {
  setup = function()
    setupLsp()
    setupLinter()
  end,
}
