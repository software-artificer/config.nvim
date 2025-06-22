local function diffview_close()
  require('diffview').close()
end

return {
  'sindrets/diffview.nvim',
  opts = {
    keymaps = {
      view = {
        { 'n', '<leader>q', diffview_close, { desc = '[Q]uit diffview' } },
      },
      file_panel = {
        { 'n', '<leader>q', diffview_close, { desc = '[Q]uit diffview' } },
      },
      file_history_panel = {
        { 'n', '<leader>q', diffview_close, { desc = '[Q]uit diffview' } },
      },
      option_panel = {
        { 'n', '<leader>q', diffview_close, { desc = '[Q]uit diffview' } },
      },
      help_panel = {
        { 'n', '<leader>q', diffview_close, { desc = '[Q]uit diffview' } },
      },
    },
  },
}
