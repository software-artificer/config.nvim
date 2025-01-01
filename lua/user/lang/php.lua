local function setupLsp()
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

local function setupDap()
  require('dap').adapters.php = {
    type = 'executable',
    command = 'node',
    args = { dap_adapter_path },
  }

  require('dap.ext.vscode').load_launchjs(launch_file_path)
end

local function setupStyle()
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

local dap_adapter_path = os.getenv('VSCODE_PHP_DEBUG_ADAPTER')
local launch_file_path = vim.fn.getcwd() .. '/.vscode/launch.json'

local has_dap = vim.fn.executable('node') == 1
  and dap_adapter_path ~= nil
  and vim.fn.filereadable(launch_file_path)

local has_lsp = vim.fn.executable('intelephense') == 1

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    if has_lsp then
      setupLsp()
    end

    if has_dap then
      setupDap()
    end

    setupStyle()
  end,
}
