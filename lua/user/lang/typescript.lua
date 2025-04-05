local has_lsp = vim.fn.executable('typescript-language-server') == 1
local has_eslint = vim.fn.executable('vscode-eslint-language-server') == 1
local has_node = vim.fn.executable('node') == 1
local has_jsdebug = vim.fn.executable('js-debug') == 1
local dap_server_path = vim.env.JSDEBUG_DAP_DEBUG_SERVER_PATH

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

local function setupDap()
  if not has_jsdebug or not dap_server_path or not has_node then
    return
  end

  local dap = require('dap')
  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { dap_server_path, '${port}' },
    },
  }
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
    setupDap()
  end,
}
