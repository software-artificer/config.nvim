local function configurePhpLsp()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  require('lspconfig').intelephense.setup({
    on_attach = function(client, bufnr)
      keymap_set({ 'n', 'v' }, '<leader>lr', function()
        vim.lsp.buf.execute_command({
          command = 'intelephense.index.workspace',
        })
        vim.print('Intelephense: Re-indexing the workspace')
      end, {
        desc = ' Intelephense: (L)SP (R)e-index workspace',
        buffer = bufnr,
      })
    end,
  }, {
    settings = {
      ['intelephense'] = {
        settings = {
          telemetry = {
            enabled = false,
          },
        },
        capabilities = capabilities,
      },
    },
  })
end

local function configurePhpDap(_, opts)
  require('dap').adapters.php = {
    type = 'executable',
    command = 'node',
    args = { opts.adapter_path },
  }

  require('dap.ext.vscode').load_launchjs(opts.launch_file)
end

return {
  {
    name = 'lang:php:lsp',
    dir = '.',
    dependencies = {
      'lang:common',
      'neovim/nvim-lspconfig',
    },
    dir = '.',
    config = configurePhpLsp,
    cond = function()
      return vim.fn.executable('intelephense') == 1
    end,
  },
  {
    name = 'lang:php:dap',
    dir = '.',
    dependencies = {
      'lang:common',
      'mfussenegger/nvim-dap',
    },
    config = configurePhpDap,
    opts = {
      adapter_path = os.getenv('VSCODE_PHP_DEBUG_ADAPTER'),
      launch_file = vim.fn.getcwd() .. '/.vscode/launch.json',
    },
    cond = function(plugin)
      return vim.fn.executable('node') == 1
        and plugin.opts.adapter_path ~= nil
        and vim.fn.filereadable(plugin.opts.launch_file)
    end,
  },
}
