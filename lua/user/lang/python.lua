local has_lsp = vim.fn.executable('basedpyright-langserver') == 1
local has_linter = vim.fn.executable('ruff') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  require('lspconfig').basedpyright.setup({})
end

local function setupLinter()
  if not has_linter then
    return
  end

  require('lspconfig').ruff.setup({})
end

return {
  setup = function()
    setupLsp()
    setupLinter()
  end,
}
