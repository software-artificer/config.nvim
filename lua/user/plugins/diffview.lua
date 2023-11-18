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

local function action_select_next_entry()
  action().select_next_entry()
end

local function action_select_prev_entry()
  action().select_prev_entry()
end

local function action_cycle_layout()
  action().cycle_layout()
end

local function action_next_conflict()
  action().next_conflict()
end

local function action_prev_conflict()
  action().prev_conflict()
end

local function noop() end

local function action_conflict_file_pick_ours()
  action().conflict_choose_all('ours')
end

local function action_conflict_file_pick_theirs()
  action().conflict_choose_all('theirs')
end

local function action_conflict_file_pick_base()
  action().conflict_choose_all('base')
end

local function action_conflict_file_pick_all()
  action().conflict_choose_all('all')
end

local function action_conflict_file_pick_none()
  action().conflict_choose_all('none')
end

local function action_close_diffview()
  require('diffview').close()
end

local function action_next_entry()
  action().next_entry()
end

local function action_prev_entry()
  action().prev_entry()
end

local function action_focus_files()
  action().focus_files()
end

local function action_scroll_up()
  action().scroll_view(-0.25)()
end

local function action_scroll_down()
  action().scroll_view(0.25)()
end

local function action_open_all_folds()
  action().open_all_folds()
end

local function action_close_all_folds()
  action().close_all_folds()
end

local function action_open_commit_log()
  action().open_commit_log()
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
        {
          { 'n', 'v' },
          '<leader>e',
          action_focus_files,
          { desc = '󱏒 Focus the file [e]xplorer panel' },
        },
        {
          { 'n', 'v' },
          '<c-n>',
          action_select_next_entry,
          { desc = '󰒭 Open the diff for the [n]ext entry' },
        },
        {
          { 'n', 'v' },
          '<c-p>',
          action_select_prev_entry,
          { desc = '󰒮 Open the diff for the [p]revious entry' },
        },
        {
          { 'n', 'v' },
          '<leader>gD',
          action_cycle_layout,
          { desc = ' Cycle through available layouts' },
        },
        {
          { 'n', 'v' },
          ']x',
          action_next_conflict,
          { desc = '󰮱 Merge - jump to the next conflict' },
        },
        {
          { 'n', 'v' },
          '[x',
          action_prev_conflict,
          { desc = '󰮳 Merge - jump to the previous conflict' },
        },
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
        {
          { 'n', 'v' },
          '<leader>cL',
          action_conflict_file_pick_ours,
          {
            desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cR',
          action_conflict_file_pick_theirs,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cB',
          action_conflict_file_pick_base,
          {
            desc = ' Conflict - Choose the [b]ase version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cA',
          action_conflict_file_pick_all,
          {
            desc = '󰕚 Conflict - Choose [a]ll/both versions for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cN',
          action_conflict_file_pick_none,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete all conflict regions from the buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>q',
          action_close_diffview,
          { desc = '󰩈 [Q]uit the diff viewer tab' },
        },
      },
      file_panel = {
        {
          'n',
          '<leader>e',
          function()
            action().toggle_files()
          end,
          { desc = '󱏒 Toggle the file [e]xplorer panel' },
        },
        {
          'n',
          '<c-n>',
          action_select_next_entry,
          { desc = '󰒭 Open the diff for the [n]ext entry' },
        },
        {
          'n',
          '<c-p>',
          action_select_prev_entry,
          { desc = '󰒮 Open the diff for the [p]revious entry' },
        },
        {
          'n',
          'j',
          action_next_entry,
          { desc = ' Move cursor to next entry' },
        },
        {
          'n',
          'k',
          action_prev_entry,
          { desc = '󰁝 Move cursor to the previous entry' },
        },
        {
          'n',
          '<leader>gD',
          action_cycle_layout,
          { desc = ' Cycle through available layouts' },
        },
        {
          'n',
          ']x',
          action_next_conflict,
          { desc = '󰮱 Merge - jump to the next conflict' },
        },
        {
          'n',
          '[x',
          action_prev_conflict,
          { desc = '󰮳 Merge - jump to the previous conflict' },
        },
        {
          'n',
          '<leader>q',
          action_close_diffview,
          { desc = '󰩈 [Q]uit the diff viewer tab' },
        },
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
        {
          'n',
          '>',
          action_open_all_folds,
          { desc = '󰪴 Expand all folds' },
        },
        {
          'n',
          '<',
          action_close_all_folds,
          { desc = '󰪦 Collapse all folds' },
        },
        {
          'n',
          '<c-u>',
          action_scroll_up,
          { desc = '󰶼 Scroll the view [u]p' },
        },
        {
          'n',
          '<c-d>',
          action_scroll_down,
          { desc = '󰶹 Scroll the view [d]own' },
        },
        {
          'n',
          'R',
          function()
            action().refresh_files()
          end,
          { desc = '󰑐 [R]efresh stats and entries in the file list' },
        },
        -- merge conflict resolution
        {
          'n',
          '<leader>cL',
          action_conflict_file_pick_ours,
          {
            desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the selected file',
          },
        },
        {
          'n',
          '<leader>cR',
          action_conflict_file_pick_theirs,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the selected file',
          },
        },
        {
          'n',
          '<leader>cB',
          action_conflict_file_pick_base,
          {
            desc = ' Conflict - Choose the [b]ase version for the selected file',
          },
        },
        {
          'n',
          '<leader>cA',
          action_conflict_file_pick_all,
          {
            desc = '󰕚 Conflict - Choose [a]ll/both versions for the selected file',
          },
        },
        {
          'n',
          '<leader>cN',
          action_conflict_file_pick_none,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete all conflict regions from the selected file',
          },
        },
        -- Disable any visual / select / insert modes and jump keymaps
        { 'n', 'v', noop, { desc = 'diffview_ignore' } },
        { 'n', 'V', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-v>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-o>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-i>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'gh', noop, { desc = 'diffview_ignore' } },
        { 'n', 'g<c-h>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'a', noop, { desc = 'diffview_ignore' } },
        { 'n', 'A', noop, { desc = 'diffview_ignore' } },
        { 'n', 'i', noop, { desc = 'diffview_ignore' } },
        { 'n', 'I', noop, { desc = 'diffview_ignore' } },
      },
      file_history_panel = {
        {
          'n',
          'o',
          function()
            action().options()
          end,
          { desc = ' Open the [o]ptions panel' },
        },
        {
          'n',
          '<leader>q',
          action_close_diffview,
          { desc = '󰩈 [Q]uit the diff viewer tab' },
        },
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
        {
          'n',
          '>',
          action_open_all_folds,
          { desc = '󰪴 Expand all folds' },
        },
        {
          'n',
          '<',
          action_close_all_folds,
          { desc = '󰪦 Collapse all folds' },
        },
        {
          'n',
          'j',
          action_next_entry,
          { desc = ' Move cursor to next entry' },
        },
        {
          'n',
          'k',
          action_prev_entry,
          { desc = '󰁝 Move cursor to the previous entry' },
        },
        {
          'n',
          '<cr>',
          action_select_entry,
          { desc = '󰂽 Open the diff for the selected entry' },
        },
        {
          'n',
          '<c-u>',
          action_scroll_up,
          { desc = '󰶼 Scroll the view [u]p' },
        },
        {
          'n',
          '<c-d>',
          action_scroll_down,
          { desc = '󰶹 Scroll the view [d]own' },
        },
        {
          'n',
          '<c-p>',
          action_select_prev_entry,
          { desc = '󰒮 Open the diff for the [p]revious entry' },
        },
        {
          'n',
          '<c-n>',
          action_select_next_entry,
          { desc = '󰒭 Open the diff for the [n]ext entry' },
        },
        {
          'n',
          '<leader>gD',
          action_cycle_layout,
          { desc = ' Cycle through available layouts' },
        },
        {
          'n',
          '<leader>e',
          action_focus_files,
          { desc = '󱏒 Focus the file [e]xplorer panel' },
        },
        -- Disable any visual / select / insert modes and jump keymaps
        { 'n', 'v', noop, { desc = 'diffview_ignore' } },
        { 'n', 'V', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-v>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-o>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-i>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'gh', noop, { desc = 'diffview_ignore' } },
        { 'n', 'g<c-h>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'a', noop, { desc = 'diffview_ignore' } },
        { 'n', 'A', noop, { desc = 'diffview_ignore' } },
        { 'n', 'i', noop, { desc = 'diffview_ignore' } },
        { 'n', 'I', noop, { desc = 'diffview_ignore' } },
      },
      option_panel = {
        {
          'n',
          '<cr>',
          action_select_entry,
          { desc = '󰔡 Toggle the current option' },
        },
        {
          'n',
          'q',
          function()
            action().close()
          end,
          { desc = '󰩈 [Q]uit the options panel' },
        },
        {
          'n',
          'o',
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
        -- Disable any visual / select / insert modes and jump keymaps
        { 'n', 'v', noop, { desc = 'diffview_ignore' } },
        { 'n', 'V', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-v>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-o>', noop, { desc = 'diffview_ignore' } },
        { 'n', '<c-i>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'gh', noop, { desc = 'diffview_ignore' } },
        { 'n', 'g<c-h>', noop, { desc = 'diffview_ignore' } },
        { 'n', 'a', noop, { desc = 'diffview_ignore' } },
        { 'n', 'A', noop, { desc = 'diffview_ignore' } },
        { 'n', 'i', noop, { desc = 'diffview_ignore' } },
        { 'n', 'I', noop, { desc = 'diffview_ignore' } },
      },
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
      mode = { 'n', 'v' },
      desc = 'Diffview:  Show commit log for current buffer',
    },
  },
}
