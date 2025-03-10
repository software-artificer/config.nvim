local function configureLanguages()
  vim.api.nvim_create_augroup('set_ident', { clear = true })

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

  local registerCapabilityHandler =
    vim.lsp.handlers['client/registerCapability']
  vim.lsp.handlers['client/registerCapability'] = function(err, params, context)
    local client = vim.lsp.get_client_by_id(context.client_id)

    for _, registration in ipairs(params.registrations) do
      -- Manage dynamic capability registration for source formatting
      if registration.method == 'textDocument/formatting' then
        lsp_format.on_attach(client, vim.fn.bufnr())
      end
    end

    return registerCapabilityHandler(err, params, context)
  end

  -- Support for context status-line
  local navic = require('nvim-navic')

  -- This is a function that will be triggered using autocmd to refresh any code
  -- lenses provided by the attached LSPs
  local function code_lens_refresh(ev)
    -- Skip any LspProgress events unless it is the end of indexing
    if
      ev.event == 'LspProgress'
      and (ev.file ~= 'end' or ev.data.params.value.title ~= 'Indexing')
    then
      return
    end

    vim.lsp.codelens.refresh({ bufnr = 0 })
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client == nil then
        return
      end

      if client.supports_method('textDocument/codeLens') then
        local timer = vim.uv.new_timer()
        vim.api.nvim_create_autocmd({
          'BufEnter',
          'LspProgress',
          'TextChanged',
          'InsertLeave',
        }, {
          callback = function(ev)
            timer:stop()
            timer:start(500, 0, function()
              timer:stop()
              vim.schedule_wrap(code_lens_refresh)(ev)
            end)
          end,
          buffer = bufnr,
        })
        keymap_set(
          'n',
          'gR',
          vim.lsp.codelens.run,
          { desc = '󰜎 LSP: Run code lens' }
        )
      end

      if client.supports_method('textDocument/formatting') then
        lsp_format.on_attach(client, bufnr)
      end

      if client.supports_method('textDocument/documentSymbol') then
        navic.attach(client, bufnr)
      end

      if client.supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

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
  keymap_set({ 'n' }, { '<leader>DB' }, function()
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
  keymap_set({ 'n' }, { '<leader>DK' }, function()
    require('dap.ui.widgets').hover()
  end, { desc = '󰽁 DAP: Evaluate the symbol under the cursor' })

  -- Make it so DAP hover can be closed with q or <leader>q
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dap-float',
    callback = function(args)
      keymap_set({ 'n' }, { 'q', '<leader>q' }, function()
        vim.api.nvim_win_close(0, true)
      end, {
        desc = '󰅗 DAP: Close the hover window',
        noremap = true,
        silent = true,
        buffer = args.buf,
      })
    end,
  })
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
    dapui.toggle()
  end, { desc = ' DAP: Open UI' })
end

local lang_deps = {
  {
    'neovim/nvim-lspconfig',
    version = '^1.2',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'lukas-reineke/lsp-format.nvim',
    },
  },
  {
    'lukas-reineke/lsp-format.nvim',
    version = '^2.7',
    keys = {
      {
        '<leader>Ff',
        function()
          require('lsp-format').toggle({ args = '' })
          vim.print('󰉼 LSP formatting toggled')
        end,
        mode = { 'n' },
        desc = '󰉼 Toggle automatic LSP formatting',
      },
    },
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
    version = '^0.9',
  },
  {
    'rcarriga/nvim-dap-ui',
    version = '^4',
    opts = {
      icons = {
        expanded = '',
        collapsed = '',
        current_frame = '󰁕',
      },
    },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap',
    },
  },
  {
    'nvim-neotest/nvim-nio',
    version = '^1.10',
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },
}

local current_module_path = ...

local function script_path()
  return debug.getinfo(1, 'S').source:sub(2)
end

local function script_dir()
  return vim.fs.dirname(script_path())
end

local function find_lua_files(dir)
  return vim.fs.dir(dir, { depth = 1 })
end

local function load_modules(dir)
  local mods = {}

  for file in find_lua_files(dir) do
    if file ~= 'init.lua' then
      local mod_name = vim.fn.fnamemodify(file, ':r')
      local mod_path = current_module_path .. '.' .. mod_name
      mods[mod_name] = require(mod_path)
    end
  end

  return mods
end

local loaded_modules = nil

local function get_language_modules()
  if loaded_modules == nil then
    loaded_modules = load_modules(script_dir())
  end

  return loaded_modules
end

local function language_modules()
  local modules = get_language_modules()
  local index, module

  return function()
    index, module = next(modules, index)
    return module
  end
end

return {
  autodetect = function()
    configureLanguages()

    for mod in language_modules() do
      mod.setup()
    end
  end,
  dependencies = function()
    local deps = vim.tbl_values(lang_deps)

    for mod in language_modules() do
      if mod.dependencies ~= nil then
        for _, dep in pairs(mod.dependencies()) do
          table.insert(deps, dep)
        end
      end
    end

    return deps
  end,
}
