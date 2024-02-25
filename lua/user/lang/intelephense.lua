return function(lspconfig, opts, bufmap)
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

  local on_attach = opts.on_attach or function() end
  opts.on_attach = function(client, bufnr)
    bufmap(bufnr, { 'n', 'v' }, '<leader>lr', function()
      vim.lsp.buf.execute_command({
        command = 'intelephense.index.workspace',
      })
      vim.print('Intelephense: Re-indexing the workspace')
    end, ' Intelephense: (L)SP (R)e-index workspace')

    return on_attach(client, bufnr)
  end

  lspconfig.intelephense.setup(vim.tbl_deep_extend('force', opts or {}, {
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
