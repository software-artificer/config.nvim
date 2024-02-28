local function setupGoLsp()
  require('lspconfig').gopls.setup({}, {
    settings = {
      ['gopls'] = {},
    },
  })
end

local function setupGoDap()
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
  {
    name = 'lang:go:lsp',
    dependencies = { 'lang:common', 'neovim/nvim-lspconfig' },
    dir = '.',
    config = setupGoLsp,
    cond = function()
      return vim.fn.executable('gopls') == 1
    end,
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'lang:common', 'mfussenegger/nvim-dap' },
    config = setupGoDap,
    cond = function()
      return vim.fn.executable('dlv') == 1
    end,
  },
}
