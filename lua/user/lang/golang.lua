local function setupLsp()
  local cwd = vim.fn.getcwd()
  local wire = vim.fn.findfile('wire.go', '.')
  local buildFlags = {}

  if f ~= '' then
    table.insert(buildFlags, '-tags=wireinject')
  end

  require('lspconfig').gopls.setup({
    settings = {
      ['gopls'] = {
        buildFlags = buildFlags,
      },
    },
  })
end

local function setupDap()
  local dap_go = require('dap-go')

  dap_go.setup({
    delve = {
      path = 'dlv',
      initialize_timeout_sec = 20,
      port = '${port}',
    },
  })

  keymap_set('n', '<leader>Dt', function()
    dap_go.debug_test()
  end, { desc = '󰨰 DAP: go - debug the test' })
  keymap_set('n', '<leader>DT', function()
    dap_go.debug_last_test()
  end, { desc = '󰨰 DAP: go - debug last test' })
end

local has_lsp = vim.fn.executable('gopls') == 1
local has_dap = vim.fn.executable('dlv') == 1

local dependencies = function()
  local deps = {}

  if has_dap then
    table.insert(deps, {
      'leoluz/nvim-dap-go',
      dependencies = { 'mfussenegger/nvim-dap' },
    })
  end

  return deps
end

local setup = function()
  if has_lsp then
    setupLsp()
  end

  if has_dap then
    setupDap()
  end
end

return {
  dependencies = dependencies,
  setup = setup,
}
