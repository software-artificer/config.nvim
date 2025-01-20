local dap_adapter_path = vim.env.VSCODE_PHP_DEBUG_ADAPTER
local has_dap = vim.fn.executable('node') == 1 and dap_adapter_path ~= nil
local has_lsp = vim.fn.executable('intelephense') == 1

local function setupLsp()
  if not has_lsp then
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
    capabilities = capabilities,
    settings = {
      intelephense = {
        telemetry = {
          enabled = false,
        },
      },
    },
  })
end

local function setupDap()
  if not has_dap then
    return
  end

  require('dap').adapters.php = {
    type = 'executable',
    command = 'node',
    args = { dap_adapter_path },
  }
end

local function setupFormatter()
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
  setup = function()
    setupLsp()
    setupFormatter()
    setupDap()
  end,
}
