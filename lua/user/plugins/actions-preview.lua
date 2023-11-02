local function setupActions()
  local plugin = require('actions-preview')
  local telescope_themes = require('telescope.themes')
  vim.keymap.set(
    { 'v', 'n' },
    '<leader>fa',
    plugin.code_actions,
    { desc = 'Telescope: Code [a]ction' }
  )

  plugin.setup({
    diff = { ctxlen = 5 },
    backend = { 'telescope' },
    telescope = {
      layout_strategy = 'vertical',
    },
  })
end

return {
  'aznhe21/actions-preview.nvim',
  config = setupActions,
}
