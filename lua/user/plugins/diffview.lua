local function configurePlugin(self, opts)
  require('diffview').setup(opts)

  vim.api.nvim_create_autocmd('BufFilePost', {
    pattern = 'diffview://*/.git/*/commit_log',
    callback = function(ev)
      keymap_set('n', { 'q', '<esc>' }, function()
        vim.api.nvim_buf_delete(ev.buf, { force = true })
      end, {
        desc = 'Diffview: 󰩈 [Q]uit the commit preview window',
        buffer = ev.buf,
      })
    end,
  })
end

local function getPluginOpts()
  local function disable_alternate_modes(keymaps)
    local function noop() end

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

  local actions = require('diffview.actions')

  local select_next_entry_keymap = {
    { 'n', 'v' },
    '<c-n>',
    actions.select_next_entry,
    { desc = '󰒭 Open the diff for the [n]ext entry' },
  }
  local select_prev_entry_keymap = {
    { 'n', 'v' },
    '<c-p>',
    actions.select_prev_entry,
    { desc = '󰒮 Open the diff for the [p]revious entry' },
  }
  local cycle_layouts_keymap = {
    { 'n', 'v' },
    '<leader>gD',
    actions.cycle_layout,
    { desc = ' Cycle through available layouts' },
  }
  local goto_next_conflict_keymap = {
    { 'n', 'v' },
    ']x',
    actions.next_conflict,
    { desc = '󰮱 Merge - jump to the next conflict' },
  }
  local goto_prev_conflict_keymap = {
    { 'n', 'v' },
    '[x',
    actions.prev_conflict,
    { desc = '󰮳 Merge - jump to the previous conflict' },
  }
  local collapse_all_folds_keymap = {
    'n',
    '<',
    actions.close_all_folds,
    { desc = '󰪦 Collapse all folds' },
  }
  local expand_all_folds_keymap = {
    'n',
    '>',
    actions.open_all_folds,
    { desc = '󰪴 Expand all folds' },
  }
  local scroll_view_down_keymap = {
    'n',
    '<c-d>',
    actions.scroll_view(0.25),
    { desc = '󰶹 Scroll the view [d]own' },
  }
  local scroll_view_up_keymap = {
    'n',
    '<c-u>',
    actions.scroll_view(-0.25),
    { desc = '󰶼 Scroll the view [u]p' },
  }
  local close_diffview_keymap = {
    { 'n', 'v' },
    '<leader>q',
    require('diffview').close,
    { desc = '󰩈 [Q]uit the diff viewer tab' },
  }
  local goto_next_entry_keymap = {
    'n',
    'j',
    actions.next_entry,
    { desc = ' Move the cursor to the next entry' },
  }
  local goto_prev_entry_keymap = {
    'n',
    'k',
    actions.prev_entry,
    { desc = '󰁝 Move the cursor to the previous entry' },
  }
  local focus_file_panel_keymap = {
    { 'n', 'v' },
    '<leader>e',
    actions.focus_files,
    { desc = '󱏒 Focus the file [e]xplorer panel' },
  }

  return {
    enhanced_diff_hl = true,
    show_help_hints = false,
    keymaps = {
      disable_defaults = true,
      view = {
        focus_file_panel_keymap,
        select_prev_entry_keymap,
        select_next_entry_keymap,
        cycle_layouts_keymap,
        goto_next_conflict_keymap,
        goto_prev_conflict_keymap,
        -- merge conflict resolution
        {
          { 'n', 'v' },
          '<leader>cl',
          function()
            actions.conflict_choose('ours')
          end,
          { desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version' },
        },
        {
          { 'n', 'v' },
          '<leader>cr',
          function()
            actions.conflict_choose('theirs')
          end,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cb',
          function()
            actions.conflict_choose('base')
          end,
          { desc = ' Conflict - Choose the [b]ase version' },
        },
        {
          { 'n', 'v' },
          '<leader>ca',
          function()
            actions.conflict_choose('all')
          end,
          { desc = '󰕚 Conflict - Choose [a]ll/both versions' },
        },
        {
          { 'n', 'v' },
          '<leader>cn',
          function()
            actions.conflict_choose('none')
          end,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete the conflict region',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cL',
          function()
            actions.conflict_choose_all('ours')
          end,
          {
            desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cR',
          function()
            actions.conflict_choose_all('theirs')
          end,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cB',
          function()
            actions.conflict_choose_all('base')
          end,
          {
            desc = ' Conflict - Choose the [b]ase version for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cA',
          function()
            actions.conflict_choose_all('all')
          end,
          {
            desc = '󰕚 Conflict - Choose [a]ll/both versions for the entire buffer',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cN',
          function()
            actions.conflict_choose_all('none')
          end,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete all conflict regions from the buffer',
          },
        },
        close_diffview_keymap,
      },
      file_panel = disable_alternate_modes({
        {
          'n',
          '<leader>e',
          actions.toggle_files,
          { desc = '󱏒 Toggle the file [e]xplorer panel' },
        },
        select_prev_entry_keymap,
        select_next_entry_keymap,
        goto_next_entry_keymap,
        goto_prev_entry_keymap,
        cycle_layouts_keymap,
        goto_next_conflict_keymap,
        goto_prev_conflict_keymap,
        close_diffview_keymap,
        {
          'n',
          '<cr>',
          actions.select_entry,
          { desc = '󰂽 Open the diff for the selected entry' },
        },
        {
          'n',
          '<leader>gS',
          actions.stage_all,
          { desc = '󱪝 [S]tage all entries' },
        },
        {
          'n',
          '<leader>gR',
          actions.unstage_all,
          { desc = '󱪟 [R]eset all staged entries' },
        },
        {
          'n',
          '<leader>gL',
          actions.open_commit_log,
          { desc = ' Show commit [l]og for the selected entry' },
        },
        {
          'n',
          '.',
          actions.open_fold,
          { desc = ' Expand fold' },
        },
        {
          'n',
          ',',
          actions.close_fold,
          { desc = ' Collapse fold' },
        },
        expand_all_folds_keymap,
        collapse_all_folds_keymap,
        scroll_view_up_keymap,
        scroll_view_down_keymap,
        {
          'n',
          'R',
          actions.refresh_files,
          { desc = '󰑐 [R]efresh stats and entries in the file list' },
        },
        -- merge conflict resolution
        {
          { 'n', 'v' },
          '<leader>cL',
          function()
            actions.conflict_choose_all('ours')
          end,
          {
            desc = '󰕛 Conflict - Choose the [l]eft/[l]ocal/our version for the selected file',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cR',
          function()
            actions.conflict_choose_all('theirs')
          end,
          {
            desc = '󰕜 Conflict - Choose the [r]ight/[r]emote/thei[r] version for the selected file',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cB',
          function()
            actions.conflict_choose_all('base')
          end,
          {
            desc = ' Conflict - Choose the [b]ase version for the selected file',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cA',
          function()
            actions.conflict_choose_all('all')
          end,
          {
            desc = '󰕚 Conflict - Choose [a]ll/both versions for the selected file',
          },
        },
        {
          { 'n', 'v' },
          '<leader>cN',
          function()
            actions.conflict_choose_all('none')
          end,
          {
            desc = '󰕢 Conflict - Choose [n]one, delete all conflict regions from the selected file',
          },
        },
      }),
      file_history_panel = disable_alternate_modes({
        {
          'n',
          'o',
          actions.options,
          { desc = ' Open the [o]ptions panel' },
        },
        close_diffview_keymap,
        {
          'n',
          'K',
          actions.open_commit_log,
          { desc = ' Show commit details for the entry under the cursor' },
        },
        {
          'n',
          'y',
          actions.copy_hash,
          {
            desc = ' [Y]ank the commit hash for the entry under the cursor',
          },
        },
        expand_all_folds_keymap,
        collapse_all_folds_keymap,
        goto_next_entry_keymap,
        goto_prev_entry_keymap,
        {
          'n',
          '<cr>',
          actions.select_entry,
          { desc = '󰂽 Open the diff for the selected entry' },
        },
        scroll_view_up_keymap,
        scroll_view_down_keymap,
        select_prev_entry_keymap,
        select_next_entry_keymap,
        cycle_layouts_keymap,
        focus_file_panel_keymap,
      }),
      option_panel = disable_alternate_modes({
        {
          'n',
          '<cr>',
          actions.select_entry,
          { desc = '󰔡 Toggle the current option' },
        },
        {
          'n',
          '<esc>',
          actions.close,
          { desc = '󰩈 Quit the options panel' },
        },
        {
          'n',
          '<leader>o',
          actions.close,
          { desc = '󰩈 Close the [o]ptions panel' },
        },
        {
          'n',
          'q',
          actions.close,
          { desc = '󰩈 [Q]uit the options panel' },
        },
      }),
    },
  }
end

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = getPluginOpts,
  setup = configurePlugin,
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
