local has_lsp = vim.fn.executable('rust-analyzer') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  require('lspconfig').rust_analyzer.setup({
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          allTargets = true,
          features = 'all',
          command = 'clippy',
        },
      },
    },
  })
end

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    setupLsp()
  end,
}
