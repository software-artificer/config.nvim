return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local diffview = require('diffview')
    local actions = require('diffview.actions')

    local keymap_close_diffview = {
      { 'n', 'v' },
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

    local keymap_select_next_entry = {
      'n',
      ']g',
      actions.select_next_entry,
      { desc = 'Open the diff for the next file' },
    }

    local keymap_select_prev_entry = {
      'n',
      '[g',
      actions.select_prev_entry,
      { desc = 'Open the diff for the previous file' },
    }

    local keymap_prev_conflict = {
      'n',
      '[x',
      actions.prev_conflict,
      { desc = 'Jump to the previous conflict' },
    }

    local keymap_next_conflict = {
      'n',
      ']x',
      actions.next_conflict,
      { desc = 'Jump to the next conflict' },
    }

    local keymap_open_all_folds =
      { 'n', '>', actions.open_all_folds, { desc = 'Expand all folds' } }

    local keymap_close_all_folds =
      { 'n', '<', actions.close_all_folds, { desc = 'Collapse all folds' } }

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
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_focus_files,
          keymap_prev_conflict,
          keymap_next_conflict,
        },
        file_panel = {
          keymap_close_diffview,
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_prev_conflict,
          keymap_next_conflict,
          keymap_open_all_folds,
          keymap_close_all_folds,
          {
            { 'n', 'v' },
            '<leader>e',
            actions.toggle_files,
            { desc = 'Toggle the file [e]xplorer panel' },
          },
        },
        file_history_panel = {
          keymap_close_diffview,
          keymap_focus_files,
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_prev_conflict,
          keymap_next_conflict,
          keymap_open_all_folds,
          keymap_close_all_folds,
        },
        option_panel = {
          {
            'n',
            '<cr>',
            actions.select_entry,
            { desc = 'Change the current option' },
          },
          {
            'n',
            '<space>',
            actions.select_entry({ desc = 'Change the current option' }),
          },
          { 'n', 'q', actions.close, { desc = 'Close the panel' } },
          { 'n', '<leader>q', actions.close, { desc = 'Close the panel' } },
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
