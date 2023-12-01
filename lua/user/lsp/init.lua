local namespace = ...

local function find_lsp_module_directory()
  local my_directory = debug.getinfo(1, 'S').source:sub(2)

  for _, path in next, vim.api.nvim_get_runtime_file('', false) do
    if my_directory:sub(1, path:len()) == path then
      return my_directory:sub(path:len() + 1, -9)
    end
  end
end

local function load_lsp_modules(lspconfig, opts)
  for _, module_path in
    next,
    vim.api.nvim_get_runtime_file(find_lsp_module_directory() .. '*.lua', true)
  do
    local basename = vim.fs.basename(module_path)
    if basename ~= 'init.lua' then
      local module = require(namespace .. '.' .. basename:sub(1, -5))
      module(lspconfig, opts)
    end
  end
end

local function configLsp()
  local lspconfig = require('lspconfig')
  local bufmap = function(bufnr, mode, keymap, action, desc)
    keymap_set(mode, keymap, action, { buffer = bufnr, desc = desc })
  end

  -- Enable cmp-nvim-lsp capabilities for LSPs
  local cmp_nvim_lsp = require('cmp_nvim_lsp')
  local lsp_defaults = lspconfig.util.default_config
  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    cmp_nvim_lsp.default_capabilities()
  )

  -- Enable formatting using LSP
  local lsp_format = require('lsp-format')
  lsp_format.setup({
    sync = true,
  })

  -- Support for context status-line
  local navic = require('nvim-navic')

  local on_attach = function(client, bufnr)
    lsp_format.on_attach(client, bufnr)

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end

    vim.o.winbar =
      '%#WinBarBackground# %{%v:lua.require("nvim-navic").get_location()%}%#WinBarBackground#'

    -- Will be available in Neovim 0.10.x
    -- vim.lsp.inlay_hints(bufnr, true)

    bufmap(
      bufnr,
      { 'n', 'v' },
      'K',
      vim.lsp.buf.hover,
      ' LSP: show symbol documentation'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gd',
      vim.lsp.buf.definition,
      '󰈮 LSP: go to the definition'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gD',
      vim.lsp.buf.declaration,
      ' LSP: go to the declaration'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gt',
      vim.lsp.buf.type_definition,
      ' LSP: go to the type definition'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gr',
      vim.lsp.buf.references,
      ' LSP: Show [r]eferences'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gi',
      vim.lsp.buf.implementation,
      ' LSP: Show [i]mplementations'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gs',
      vim.lsp.buf.document_symbol,
      ' LSP: Show document [s]ymbols'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gS',
      vim.lsp.buf.workspace_symbol,
      ' LSP: Show workspace [s]ymbols'
    )
    bufmap(
      bufnr,
      { 'n', 'v' },
      'gA',
      vim.lsp.buf.code_action,
      ' LSP: Show code [a]ctions'
    )
    bufmap(
      bufnr,
      'n',
      '<leader>hs',
      vim.lsp.buf.signature_help,
      '󱜻 LSP: Show singature help'
    )
  end

  -- Load all LSP drop-in configurations
  load_lsp_modules(lspconfig, { on_attach = on_attach })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'lukas-reineke/lsp-format.nvim',
    },
    config = configLsp,
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
}
