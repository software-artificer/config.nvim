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
end

local function configurePhpStyle()
  vim.api.nvim_create_autocmd('FileType', {
    group = 'set_ident',
    pattern = 'php',
    desc = 'Set proper identation for PHP files',
    callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
      vim.opt_local.expandtab = true
    end,
  })
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
    },
    cond = function(plugin)
      return vim.fn.executable('node') == 1 and plugin.opts.adapter_path ~= nil
    end,
  },
  {
    name = 'lang:php:style',
    dir = '.',
    dependencies = {
      'lang:common',
    },
    config = configurePhpStyle,
  },
}
