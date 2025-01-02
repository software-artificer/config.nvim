local has_lsp = vim.fn.executable('nil') == 1
local has_formatter = vim.fn.executable('nixfmt') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  local caps = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities(),
    { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
  )

  local formatting = {}
  if has_formatter then
    formatting = { command = { 'nixfmt' } }
  end

  require('lspconfig').nil_ls.setup({
    capabilities = caps,
    cmd = { 'nil' },
    settings = {
      ['nil'] = {
        formatting = formatting,
      },
    },
  })
end

local function setupFormatter()
  if not has_formatter then
    return
  end

  if has_lsp then
    return
  end

  require('null-ls.sources').register(
    require('null-ls').builtins.formatting.nixfmt
  )
end

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    setupLsp()
  end,
}
