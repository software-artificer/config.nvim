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

    local keymap_conflict_choose_all_ours = {
      'n',
      '<leader>cO',
      actions.conflict_choose_all('ours'),
      { desc = 'Choose the OURS version of the conflict' },
    }

    local keymap_conflict_choose_all_theirs = {
      'n',
      '<leader>cT',
      actions.conflict_choose_all('theirs'),
      { desc = 'Choose the THEIRS version of the conflict' },
    }

    local keymap_conflict_choose_all_base = {
      'n',
      '<leader>cB',
      actions.conflict_choose_all('base'),
      { desc = 'Choose the BASE version of the conflict' },
    }

    local keymap_conflict_choose_all_both = {
      'n',
      '<leader>cA',
      actions.conflict_choose_all('all'),
      { desc = 'Choose ALL the versions of the conflict' },
    }

    local keymap_conflict_choose_all_none = {
      'n',
      '<leader>cN',
      actions.conflict_choose_all('none'),
      {
        desc = 'Choose NONE of the versions, delete all conflict regions in the file',
      },
    }

    local keymap_cycle_layout = {
      'n',
      '<C-w><C-x>',
      actions.cycle_layout,
      { desc = 'Cycle through available layouts' },
    }

    local keymap_scroll_view_up = {
      'n',
      '<C-b>',
      actions.scroll_view(-0.25),
      { desc = 'Scroll the view up' },
    }

    local keymap_scroll_view_down = {
      'n',
      '<C-f>',
      actions.scroll_view(0.25),
      { desc = 'Scroll the view down' },
    }

    local keymap_next_entry = {
      'n',
      'j',
      actions.next_entry,
      { desc = 'Bring the cursor to the next file entry' },
    }

    local keymap_prev_entry = {
      'n',
      'k',
      actions.prev_entry,
      { desc = 'Bring the cursor to the previous file entry' },
    }

    local keymap_open_fold =
      { 'n', '.', actions.open_fold, { desc = 'Expand fold' } }

    local keymap_close_fold =
      { 'n', ',', actions.close_fold, { desc = 'Collapse fold' } }

    local keymap_select_entry = {
      'n',
      '<cr>',
      actions.select_entry,
      { desc = 'Open the diff for the selected entry' },
    }

    local keymap_restore_entry = {
      'n',
      'X',
      actions.restore_entry,
      { desc = 'Restore entry to the state on the left side' },
    }

    local keymap_open_commit_log = {
      'n',
      'L',
      actions.open_commit_log,
      { desc = 'Open the commit log panel' },
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
        disable_defaults = true,
        view = {
          keymap_close_diffview,
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_focus_files,
          keymap_prev_conflict,
          keymap_next_conflict,
          keymap_conflict_choose_all_ours,
          keymap_conflict_choose_all_theirs,
          keymap_conflict_choose_all_base,
          keymap_conflict_choose_all_both,
          keymap_conflict_choose_all_none,
          keymap_cycle_layout,
          {
            'n',
            '<leader>co',
            actions.conflict_choose('ours'),
            { desc = 'Choose the OURS version of a conflict' },
          },
          {
            'n',
            '<leader>ct',
            actions.conflict_choose('theirs'),
            { desc = 'Choose the THEIRS version of a conflict' },
          },
          {
            'n',
            '<leader>cb',
            actions.conflict_choose('base'),
            { desc = 'Choose the BASE version of a conflict' },
          },
          {
            'n',
            '<leader>ca',
            actions.conflict_choose('all'),
            { desc = 'Choose all the versions of a conflict' },
          },
          {
            'n',
            '<leader>cn',
            actions.conflict_choose('none'),
            { desc = 'Delete the conflict region' },
          },
        },
        diff3 = {},
        diff4 = {},
        file_panel = {
          keymap_close_diffview,
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_prev_conflict,
          keymap_next_conflict,
          keymap_open_fold,
          keymap_close_fold,
          keymap_open_all_folds,
          keymap_close_all_folds,
          keymap_conflict_choose_all_ours,
          keymap_conflict_choose_all_theirs,
          keymap_conflict_choose_all_base,
          keymap_conflict_choose_all_both,
          keymap_conflict_choose_all_none,
          keymap_cycle_layout,
          keymap_scroll_view_up,
          keymap_scroll_view_down,
          keymap_next_entry,
          keymap_prev_entry,
          keymap_select_entry,
          keymap_restore_entry,
          keymap_open_commit_log,
          {
            { 'n', 'v' },
            '<leader>e',
            actions.toggle_files,
            { desc = 'Toggle the file [e]xplorer panel' },
          },
          {
            'n',
            's',
            actions.toggle_stage_entry,
            { desc = 'Stage / unstage the selected entry' },
          },
          {
            'n',
            'S',
            actions.stage_all,
            { desc = 'Stage all entries' },
          },
          {
            'n',
            'U',
            actions.unstage_all,
            { desc = 'Unstage all entries' },
          },
          {
            'n',
            'R',
            actions.refresh_files,
            { desc = 'Update stats and entries in the file list' },
          },
          {
            'n',
            '<C-w><C-x>',
            actions.cycle_layout,
            { desc = 'Cycle available layouts' },
          },
        },
        file_history_panel = {
          keymap_close_diffview,
          keymap_focus_files,
          keymap_select_prev_entry,
          keymap_select_next_entry,
          keymap_prev_conflict,
          keymap_next_conflict,
          keymap_open_fold,
          keymap_close_fold,
          keymap_open_all_folds,
          keymap_close_all_folds,
          keymap_cycle_layout,
          keymap_scroll_view_up,
          keymap_scroll_view_down,
          keymap_next_entry,
          keymap_prev_entry,
          keymap_select_entry,
          keymap_restore_entry,
          keymap_open_commit_log,
          {
            'n',
            'y',
            actions.copy_hash,
            { desc = 'Copy the commit hash of the entry under the cursor' },
          },
          {
            'n',
            '<leader>gD',
            actions.open_in_diffview,
            { desc = 'Open the entry under the cursor in a diffview' },
          },
          {
            'n',
            '!!',
            actions.options,
            { desc = 'Open the option panel' },
          },
        },
        option_panel = {
          {
            'n',
            '<cr>',
            actions.select_entry,
            { desc = 'Change the current option' },
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
    {
      '<leader>gH',
      function()
        require('diffview').file_history()
      end,
      mode = { 'n', 'v' },
      desc = 'Open file history in diffview',
    },
  },
}
