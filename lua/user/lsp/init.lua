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

local function bufmap(mode, keymap, action, desc)
  vim.keymap.set(mode, keymap, action, { buffer = true, desc = desc })
end

local function configLsp()
  local lspconfig = require('lspconfig')

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
  local on_attach = function(client, bufnr)
    lsp_format.on_attach(client, bufnr)

    -- Will be available in Neovim 0.10.x
    -- vim.lsp.inlay_hints(bufnr, true)

    bufmap('n', 'K', vim.lsp.buf.hover, 'LSP: show symbol documentation')
    bufmap('n', 'gd', vim.lsp.buf.definition, 'LSP: go to definition')
    bufmap('n', 'gD', vim.lsp.buf.declaration, 'LSP: go to declaration')

    -- Lists all the implementations for the symbol under the cursor
    -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    -- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    -- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
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
    tag = 'v2.6.3',
  },
}
