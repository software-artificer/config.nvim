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

local function setupFormatter()
  vim.api.nvim_create_autocmd('FileType', {
    group = 'set_ident',
    pattern = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
    },
    desc = 'Set proper identation for JavaScript/TypeScript files',
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.expandtab = true
    end,
  })
end

return {
  setup = function()
    setupLsp()
    setupEslint()
    setupFormatter()
  end,
}
