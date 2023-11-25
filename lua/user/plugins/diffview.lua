vim.api.nvim_create_autocmd('BufFilePost', {
  pattern = 'diffview://*/.git/*/commit_log',
  callback = function(ev)
    print(vim.inspect(ev))
    keymap_set('n', { 'q', '<esc>' }, function()
      vim.api.nvim_buf_delete(ev.buf, { force = true })
    end, {
      desc = 'Diffview: 󰩈 [Q]uit the commit preview window',
      buffer = ev.buf,
    })
  end,
})

local function action()
  return require('diffview.actions')
end

local function action_select_entry()
  action().select_entry()
end

local function select_next_entry_keymap()
  return {
    { 'n', 'v' },
    '<c-n>',
    function()
      action().select_next_entry()
    end,
    { desc = '󰒭 Open the diff for the [n]ext entry' },
  }
end

local function select_prev_entry_keymap()
  return {
    { 'n', 'v' },
    '<c-p>',
    function()
      action().select_prev_entry()
    end,
    { desc = '󰒮 Open the diff for the [p]revious entry' },
  }
end

local function cycle_layouts_keymap()
  return {
    { 'n', 'v' },
    '<leader>gD',
    function()
      action().cycle_layout()
    end,
    { desc = ' Cycle through available layouts' },
  }
end

local function goto_next_conflict_keymap()
  return {
    { 'n', 'v' },
    ']x',
    function()
      action().next_conflict()
    end,
    { desc = '󰮱 Merge - jump to the next conflict' },
  }
end

local function goto_prev_conflict_keymap()
  return {
    { 'n', 'v' },
    '[x',
    function()
      action().prev_conflict()
    end,
    { desc = '󰮳 Merge - jump to the previous conflict' },
  }
end

local function noop() end

local function conflict_pick_ours_for_file_keymap(desc)
  return {
    { 'n', 'v' },
    '<leader>cL',
    function()
      action().conflict_choose_all('ours')
    end,
    { desc = desc },
  }
end

local function conflict_pick_theirs_for_file_keymap(desc)
  return {
    { 'n', 'v' },
    '<leader>cR',
    function()
      action().conflict_choose_all('theirs')
    end,
    {
      desc = desc,
    },
  }
end

local function conflict_pick_base_for_file_keymap(desc)
  return {
    { 'n', 'v' },
    '<leader>cB',
    function()
      action().conflict_choose_all('base')
    end,
    {
      desc = desc,
    },
  }
end

local function conflict_pick_both_for_file_keymap(desc)
  return {
    { 'n', 'v' },
    '<leader>cA',
    function()
      action().conflict_choose_all('all')
    end,
    {
      desc = desc,
    },
  }
end

local function conflict_pick_none_for_file_keymap(desc)
  return {
    { 'n', 'v' },
    '<leader>cN',
    function()
      action().conflict_choose_all('none')
    end,
    {
      desc = desc,
    },
  }
end

local function close_diffview_keymap()
  return {
    { 'n', 'v' },
    '<leader>q',
    function()
      require('diffview').close()
    end,
    { desc = '󰩈 [Q]uit the diff viewer tab' },
  }
end

local function goto_next_entry_keymap()
  return {
    'n',
    'j',
    function()
      action().next_entry()
    end,
    { desc = ' Move the cursor to the next entry' },
  }
end

local function goto_prev_entry_keymap()
  return {
    'n',
    'k',
    function()
      action().prev_entry()
    end,
    { desc = '󰁝 Move the cursor to the previous entry' },
  }
end

local function focus_file_panel_keymap()
  return {
    { 'n', 'v' },
    '<leader>e',
    function()
      action().focus_files()
    end,
    { desc = '󱏒 Focus the file [e]xplorer panel' },
  }
end

local function scroll_view_up_keymap()
  return {
    'n',
    '<c-u>',
    function()
      action().scroll_view(-0.25)()
    end,
    { desc = '󰶼 Scroll the view [u]p' },
  }
end

local function scroll_view_down_keymap()
  return {
    'n',
    '<c-d>',
    function()
      action().scroll_view(0.25)()
    end,
    { desc = '󰶹 Scroll the view [d]own' },
  }
end

local function expand_all_folds_keymap()
  return {
    'n',
    '>',
    function()
      action().open_all_folds()
    end,
    { desc = '󰪴 Expand all folds' },
  }
end

local function collapse_all_folds_keymap()
  return {
    'n',
    '<',
    function()
      action().close_all_folds()
    end,
    { desc = '󰪦 Collapse all folds' },
  }
end

local function action_open_commit_log()
  action().open_commit_log()
end

local function disable_alternate_modes(keymaps)
  table.insert(keymaps, { 'n', 'v', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'V', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', '<c-v>', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', '<c-o>', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', '<c-i>', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'gh', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'g<c-h>', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'a', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'A', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'i', noop, { desc = 'diffview_ignore' } })
  table.insert(keymaps, { 'n', 'I', noop, { desc = 'diffview_ignore' } })

  return keymaps
end

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    enhanced_diff_hl = true,
    show_help_hints = false,
    keymaps = {
      disable_defaults = true,
      view = {
        focus_file_panel_keymap(),
        select_prev_entry_keymap(),
        select_next_entry_keymap(),
        cycle_layouts_keymap(),
        goto_next_conflict_keymap(),
        goto_prev_conflict_keymap(),
        -- merge conflict resolution
        {
          { 'n', 'v' },
          '<leader>cl',
          function()
            action().conflict_choose('ours')
          end,
          { desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version' },
        },
        {
          { 'n', 'v' },
          '<leader>cr',
          function()
            action().conflict_choose('theirs')
          end,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cb',
          function()
            action().conflict_choose('base')
          end,
          { desc = ' Conflict - Choose the [b]ase version' },
        },
        {
          { 'n', 'v' },
          '<leader>ca',
          function()
            action().conflict_choose('all')
          end,
          { desc = '󰕚 Conflict - Choose [a]ll/both versions' },
        },
        {
          { 'n', 'v' },
          '<leader>cn',
          function()
            action().conflict_choose('none')
          end,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete the conflict region',
          },
        },
        conflict_pick_ours_for_file_keymap(
          '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the entire buffer'
        ),
        conflict_pick_theirs_for_file_keymap(
          '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the entire buffer'
        ),
        conflict_pick_base_for_file_keymap(
          ' Conflict - Choose the [b]ase version for the entire buffer'
        ),
        conflict_pick_both_for_file_keymap(
          '󰕚 Conflict - Choose [a]ll/both versions for the entire buffer'
        ),
        conflict_pick_none_for_file_keymap(
          '󰕢 Conflict - Choose [n]one, delete all conflict regions from the buffer'
        ),
        close_diffview_keymap(),
      },
      file_panel = disable_alternate_modes({
        {
          'n',
          '<leader>e',
          function()
            action().toggle_files()
          end,
          { desc = '󱏒 Toggle the file [e]xplorer panel' },
        },
        select_prev_entry_keymap(),
        select_next_entry_keymap(),
        goto_next_entry_keymap(),
        goto_prev_entry_keymap(),
        cycle_layouts_keymap(),
        goto_next_conflict_keymap(),
        goto_prev_conflict_keymap(),
        close_diffview_keymap(),
        {
          'n',
          '<cr>',
          action_select_entry,
          { desc = '󰂽 Open the diff for the selected entry' },
        },
        {
          'n',
          '<leader>gS',
          function()
            action().stage_all()
          end,
          { desc = '󱪝 [S]tage all entries' },
        },
        {
          'n',
          '<leader>gR',
          function()
            action().unstage_all()
          end,
          { desc = '󱪟 [R]eset all staged entries' },
        },
        {
          'n',
          '<leader>gL',
          action_open_commit_log,
          { desc = ' Show commit [l]og for the selected entry' },
        },
        {
          'n',
          '.',
          function()
            action().open_fold()
          end,
          { desc = ' Expand fold' },
        },
        {
          'n',
          ',',
          function()
            action().close_fold()
          end,
          { desc = ' Collapse fold' },
        },
        expand_all_folds_keymap(),
        collapse_all_folds_keymap(),
        scroll_view_up_keymap(),
        scroll_view_down_keymap(),
        {
          'n',
          'R',
          function()
            action().refresh_files()
          end,
          { desc = '󰑐 [R]efresh stats and entries in the file list' },
        },
        -- merge conflict resolution
        conflict_pick_ours_for_file_keymap(
          '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the selected file'
        ),
        conflict_pick_theirs_for_file_keymap(
          '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the selected file'
        ),
        conflict_pick_base_for_file_keymap(
          ' Conflict - Choose the [b]ase version for the selected file'
        ),
        conflict_pick_both_for_file_keymap(
          '󰕚 Conflict - Choose [a]ll/both versions for the selected file'
        ),
        conflict_pick_none_for_file_keymap(
          '󰕢 Conflict - Choose [n]one, delete all conflict regions from the selected file'
        ),
      }),
      file_history_panel = disable_alternate_modes({
        {
          'n',
          'o',
          function()
            action().options()
          end,
          { desc = ' Open the [o]ptions panel' },
        },
        close_diffview_keymap(),
        {
          'n',
          'K',
          action_open_commit_log,
          { desc = ' Show commit details for the entry under the cursor' },
        },
        {
          'n',
          'y',
          function()
            action().copy_hash()
          end,
          {
            desc = ' [Y]ank the commit hash for the entry under the cursor',
          },
        },
        expand_all_folds_keymap(),
        collapse_all_folds_keymap(),
        goto_next_entry_keymap(),
        goto_prev_entry_keymap(),
        {
          'n',
          '<cr>',
          action_select_entry,
          { desc = '󰂽 Open the diff for the selected entry' },
        },
        scroll_view_up_keymap(),
        scroll_view_down_keymap(),
        select_prev_entry_keymap(),
        select_next_entry_keymap(),
        cycle_layouts_keymap(),
        focus_file_panel_keymap(),
      }),
      option_panel = disable_alternate_modes({
        {
          'n',
          '<cr>',
          action_select_entry,
          { desc = '󰔡 Toggle the current option' },
        },
        {
          'n',
          '<esc>',
          function()
            action().close()
          end,
          { desc = '󰩈 Quit the options panel' },
        },
        {
          'n',
          '<leader>o',
          function()
            action().close()
          end,
          { desc = '󰩈 Close the [o]ptions panel' },
        },
        {
          'n',
          'q',
          function()
            action().close()
          end,
          { desc = '󰩈 [Q]uit the options panel' },
        },
      }),
    },
  },
  keys = {
    {
      '<leader>gD',
      function()
        require('diffview').open()
      end,
      mode = { 'n', 'v' },
      desc = 'Diffview:  Show diff for current buffer',
    },
    {
      '<leader>gL',
      function()
        require('diffview').file_history()
      end,
      mode = 'n',
      desc = 'Diffview:  Show commit log for current buffer',
    },
    {
      '<leader>gL',
      function()
        local from = vim.api.nvim_buf_get_mark(0, '<')[1]
        local to = vim.api.nvim_buf_get_mark(0, '>')[1]
        require('diffview').file_history({ from, to })
      end,
      mode = 'v',
      desc = 'Diffview:  Show commit log for selection',
    },
  },
}
