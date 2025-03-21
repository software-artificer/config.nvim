local has_lsp = vim.fn.executable('docker-langserver') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  require('lspconfig').dockerls.setup({
    settings = {
      docker = {
        languageserver = {
          formatter = {
            ignoreMultilineInstructions = true,
          },
        },
      },
    },
  })
end

return {
  setup = function()
    setupLsp()
  end,
}
