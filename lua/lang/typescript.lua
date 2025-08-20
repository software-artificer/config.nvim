local have_lsp = vim.fn.executable('typescript-language-server') == 1
local have_eslint = vim.fn.executable('vscode-eslint-language-server') == 1
local have_node = vim.fn.executable('node') == 1
local have_jsdebug = vim.fn.executable('js-debug') == 1
local dap_server_path = vim.env.JSDEBUG_DAP_DEBUG_SERVER_PATH

return {
  name = 'lang:typescript',
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/typescript/',
  opts = {
    debugger = {
      enabled = have_jsdebug and dap_server_path and have_node,
      dap_path = dap_server_path,
    },
    eslint = { enabled = have_eslint },
    lsp = { enabled = have_lsp },
  },
  dependencies = {
    'mfussenegger/nvim-dap',
    'neovim/nvim-lspconfig',
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Set proper identation for JavaScript/TypeScript files',
      pattern = {
        'typescript',
        'javascript',
        'typescriptreact',
        'javascriptreact',
      },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
      end,
    })

    if opts.lsp and opts.lsp.enabled then
      vim.lsp.enable('ts_ls')
    end

    if opts.debugger and opts.debugger.enabled then
      local dap_path = opts.debugger.dap_path or 'vscode-js-debug'

      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { opts.debugger.dap_path, '${port}' },
        },
      }
    end

    if opts.eslint and opts.eslint.enabled then
      vim.lsp.enable('eslint')
    end
  end,
}
