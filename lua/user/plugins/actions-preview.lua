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
end

return {
  'aznhe21/actions-preview.nvim',
  config = setupActions,
  keys = {
    {
      '<leader>fa',
      function()
        require('actions-preview').code_actions()
      end,
      mode = { 'v', 'n' },
      desc = ' Telescope: LSP - Show code [a]ctions',
    },
  },
}
