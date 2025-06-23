return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local diffview = require('diffview')
    local actions = require('diffview.actions')

    local keymap_close_diffview = {
      'n',
      '<leader>q',
      diffview.close,
      { desc = '[Q]uit diffview' },
    }

    local keymap_focus_files = {
      { 'n', 'v' },
      '<leader>e',
      actions.focus_files,
      { desc = 'Focus the file [e]xplorer panel' },
    }

    return {
      view = {
        default = {
          disable_diagnostics = true,
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      icons = {
        folder_closed = '',
        folder_open = '',
      },
      signs = {
        fold_closed = '',
        fold_open = '',
        done = '',
      },
      keymaps = {
        view = {
          keymap_close_diffview,
          keymap_focus_files,
        },
        file_panel = {
          keymap_close_diffview,
          keymap_focus_files,
        },
        file_history_panel = {
          keymap_close_diffview,
          keymap_focus_files,
        },
        option_panel = {
          keymap_close_diffview,
          keymap_focus_files,
        },
      },
      enhanced_diff_hl = true,
    }
  end,
  keys = {
    {
      '<leader>gD',
      function()
        require('diffview').open()
      end,
      mode = { 'n', 'v' },
      desc = 'Open diffview',
    },
  },
}
