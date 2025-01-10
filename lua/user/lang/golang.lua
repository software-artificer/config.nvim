local has_lsp = vim.fn.executable('gopls') == 1
local has_dap = vim.fn.executable('dlv') == 1
local has_revive = vim.fn.executable('revive') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

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

local function setupLints()
  if not has_revive then
    return
  end

  local none_ls = require('null-ls')
  none_ls.register(none_ls.builtins.diagnostics.revive)
end

local function setupDap()
  if not has_dap then
    return
  end

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

return {
  dependencies = function()
    return {
      {
        'leoluz/nvim-dap-go',
        dependencies = { 'mfussenegger/nvim-dap' },
        cond = has_dap,
      },
    }
  end,
  setup = function()
    setupLsp()
    setupLints()
    setupDap()
  end,
}
