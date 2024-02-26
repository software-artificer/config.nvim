local function configLanguages()
  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  local lsp_defaults = lspconfig.util.default_config
  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    -- Enable cmp-nvim-lsp capabilities for LSPs
    cmp_nvim_lsp.default_capabilities()
  )

  -- Enable formatting using LSP
  local lsp_format = require('lsp-format')
  lsp_format.setup({
    sync = true,
  })

  -- Support for context status-line
  local navic = require('nvim-navic')

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client == nil then
        return
      end

      lsp_format.on_attach(client, bufnr)

      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      -- Will be available in Neovim 0.10.x
      -- vim.lsp.inlay_hints(bufnr, true)

      keymap_set(
        { 'n', 'v' },
        'K',
        vim.lsp.buf.hover,
        { buffer = bufnr, desc = ' LSP: show symbol documentation' }
      )
      keymap_set(
        { 'n', 'v' },
        'gd',
        vim.lsp.buf.definition,
        { buffer = bufnr, desc = '󰈮 LSP: go to the definition' }
      )
      keymap_set(
        { 'n', 'v' },
        'gD',
        vim.lsp.buf.declaration,
        { buffer = bufnr, desc = ' LSP: go to the declaration' }
      )
      keymap_set(
        { 'n', 'v' },
        'gt',
        vim.lsp.buf.type_definition,
        { buffer = bufnr, desc = ' LSP: go to the type definition' }
      )
      keymap_set(
        { 'n', 'v' },
        'gr',
        vim.lsp.buf.references,
        { buffer = bufnr, desc = ' LSP: Show [r]eferences' }
      )
      keymap_set(
        { 'n', 'v' },
        'gi',
        vim.lsp.buf.implementation,
        { buffer = bufnr, desc = ' LSP: Show [i]mplementations' }
      )
      keymap_set(
        { 'n', 'v' },
        'gs',
        vim.lsp.buf.document_symbol,
        { buffer = bufnr, desc = ' LSP: Show document [s]ymbols' }
      )
      keymap_set(
        { 'n', 'v' },
        'gS',
        vim.lsp.buf.workspace_symbol,
        { buffer = bufnr, desc = ' LSP: Show workspace [s]ymbols' }
      )
      keymap_set(
        { 'n', 'v' },
        'gA',
        vim.lsp.buf.code_action,
        { buffer = bufnr, desc = ' LSP: Show code [a]ctions' }
      )
      keymap_set(
        'n',
        '<leader>hs',
        vim.lsp.buf.signature_help,
        { buffer = bufnr, desc = '󱜻 LSP: Show singature help' }
      )
    end,
  })

  local dap = require('dap')
  keymap_set({ 'n' }, { '<leader>Db' }, function()
    dap.toggle_breakpoint()
  end, { desc = ' DAP: Toggle breakpoint' })
  keymap_set({ 'n' }, { '<leader>Dc' }, function()
    dap.continue()
  end, { desc = ' DAP: Continue execution' })
  keymap_set({ 'n' }, { '<leader>Dw' }, function()
    dap.step_over()
  end, { desc = ' DAP: Step over' })
  keymap_set({ 'n' }, { '<leader>Dl' }, function()
    dap.step_into()
  end, { desc = ' DAP: Step into' })
  keymap_set({ 'n' }, { '<leader>Dh' }, function()
    dap.step_out()
  end, { desc = ' DAP: Step out' })
  keymap_set({ 'n' }, { '<leader>Dq' }, function()
    dap.terminate()
  end, { desc = '󰜺 DAP: terminate' })
  keymap_set({ 'n' }, { '<leader>Dk' }, function()
    dap.down()
  end, { desc = '󱞺 DAP: Go up the stack' })
  keymap_set({ 'n' }, { '<leader>Dj' }, function()
    dap.up()
  end, { desc = '󱞰 DAP: Go down the stack' })
  -- TODO:
  -- focus_frame
  -- run_last
  -- restart
  -- clear_breakpoints
  -- list_breakpoints
  -- set_exception_breakpoints
  -- step_back
  -- pause
  -- reverse_continue
  -- restart_frame
  -- run_to_cursor
  -- repl

  local dapui = require('dapui')
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
  keymap_set({ 'n' }, { '<leader>Du' }, function()
    if dap.session() == nil then
      return
    end

    dapui.toggle()
  end, { desc = ' DAP: Open UI' })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'lukas-reineke/lsp-format.nvim',
    },
  },
  {
    'lukas-reineke/lsp-format.nvim',
    version = '^2.6',
  },
  {
    'SmiteshP/nvim-navic',
    opts = {
      highlight = true,
      separator = '  ',
      icons = {
        Module = '󰕳 ',
        Class = ' ',
        Method = '󰰐 ',
        Property = ' ',
        Constructor = '󱥉 ',
        Enum = ' ',
        Interface = ' ',
        Function = '󰊕 ',
        Variable = '󱄑 ',
        Constant = '󰏿 ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'mfussenegger/nvim-dap',
    version = '^0.7',
  },
  {
    'rcarriga/nvim-dap-ui',
    version = '^3',
    opts = {
      icons = {
        expanded = '',
        collapsed = '',
        current_frame = '󰁕',
      },
    },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
  {
    name = 'lang:common',
    dir = '.',
    config = configLanguages,
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
  },
}
