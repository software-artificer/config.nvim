local function setupLsp()
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

local has_lsp = vim.fn.executable('rust-analyzer') == 1

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    if has_lsp then
      setupLsp()
    end
  end,
}
