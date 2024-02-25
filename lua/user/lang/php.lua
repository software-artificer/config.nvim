local function setup_lsp(set_keymap_fn, lspconfig, lsp_opts)
  if vim.fn.executable('intelephense') ~= 1 then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  local on_attach = lsp_opts.on_attach or function() end
  lsp_opts.on_attach = function(client, bufnr)
    set_keymap_fn(bufnr, { 'n', 'v' }, '<leader>lr', function()
      vim.lsp.buf.execute_command({
        command = 'intelephense.index.workspace',
      })
      vim.print('Intelephense: Re-indexing the workspace')
    end, ' Intelephense: (L)SP (R)e-index workspace')

    return on_attach(client, bufnr)
  end

  lspconfig.intelephense.setup(vim.tbl_deep_extend('force', lsp_opts or {}, {
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
  }))
end

local function setup_dap(dap)
  if vim.fn.executable('node') ~= 1 then
    return
  end

  local adapter_path = os.getenv('VSCODE_PHP_DEBUG_ADAPTER')
  if adapter_path == nil then
    return
  end

  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { adapter_path },
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9003,
    },
  }
end

return function(set_keymap_fn, lspconfig, lsp_opts, dap)
  setup_lsp(set_keymap_fn, lspconfig, lsp_opts)
  setup_dap(dap)
end
