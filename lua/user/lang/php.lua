local function setupLsp()
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

      return on_attach(client, bufnr)
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

local function setupDap()
  if vim.fn.executable('node') ~= 1 then
    return
  end

  local adapter_path = os.getenv('VSCODE_PHP_DEBUG_ADAPTER')
  if adapter_path == nil then
    return
  end

  local launch_file = vim.fn.getcwd() .. '/.vscode/launch.json'
  if not vim.fn.filereadable(launch_file) then
    return
  end

  require('dap').adapters.php = {
    type = 'executable',
    command = 'node',
    args = { adapter_path },
  }

  require('dap.ext.vscode').load_launchjs(launch_file)
end

local function configurePhp()
  setupLsp()
  setupDap()
end

return {
  name = 'lang:php',
  depends = { 'lang:common', 'neovim/nvim-lspconfig', 'mfussenegger/nvim-dap' },
  dir = '.',
  config = configurePhp,
}
