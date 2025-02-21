local has_lsp = vim.fn.executable('typescript-language-server') == 1
local has_eslint = vim.fn.executable('vscode-eslint-language-server') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  require('lspconfig').ts_ls.setup({})
end

local function setupEslint()
  if not has_eslint then
    return
  end

  require('lspconfig').eslint.setup({})
end

return {
  setup = function()
    setupLsp()
    setupEslint()
  end,
}
