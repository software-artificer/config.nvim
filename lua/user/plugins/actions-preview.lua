local function setupActions()
  local plugin = require('actions-preview')
  local telescope_themes = require('telescope.themes')

  plugin.setup({
    diff = { ctxlen = 5 },
    backend = { 'telescope' },
    telescope = {
      layout_strategy = 'vertical',
    },
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
      vim.lsp.buf.code_action = plugin.code_actions
    end,
  })
end

return {
  'aznhe21/actions-preview.nvim',
  config = setupActions,
}
