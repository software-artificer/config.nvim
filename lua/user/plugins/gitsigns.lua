return {
  'lewis6991/gitsigns.nvim',
  version = '^0.7',
  opts = {
    signs = {
      untracked = { text = '󰇙' },
    },
    current_line_blame_formatter = '<author_time:%Y-%m-%d at %H:%M:%S> by <author>: <summary>',
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      local function map(modes, keymaps, action, description)
        keymap_set(
          modes,
          keymaps,
          action,
          { buffer = bufnr, desc = description }
        )
      end

      map(
        { 'n', 'v' },
        '<leader>gb',
        gitsigns.toggle_current_line_blame,
        '󰋇 GitSigns: Enable current line blame'
      )
      map('n', '<leader>gB', function()
        gitsigns.blame_line({ full = true })
      end, '󰋇 GitSigns: Show blame for line under the cursor')
      map(
        'n',
        '<leader>gp',
        gitsigns.preview_hunk_inline,
        ' GitSigns: Preview hunk inline'
      )
      map(
        'n',
        '<leader>gP',
        gitsigns.preview_hunk,
        ' GitSigns: Preview hunk'
      )
      map(
        'n',
        '<leader>gd',
        gitsigns.toggle_deleted,
        '󱀸 GitSigns: Toggle deleted lines'
      )
      map('n', '<leader>gs', gitsigns.stage_hunk, ' GitSigns: Stage hunk')
      map('v', '<leader>gs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, '󰐒 GitSigns: Stage selection')
      map('n', '<leader>gr', gitsigns.reset_hunk, ' GitSigns: Reset hunk')
      map('v', '<leader>gr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, '󰐓 GitSigns: Reset selection')
      map(
        { 'n', 'v' },
        '<leader>gS',
        gitsigns.stage_buffer,
        '󱪝 GitSigns: Stage all hunks in the buffer'
      )
      map(
        { 'n', 'v' },
        '<leader>gR',
        gitsigns.reset_buffer,
        '󱪟 GitSigns: Reset all hunks in the buffer'
      )
      map(
        { 'n', 'v' },
        '<leader>gu',
        gitsigns.undo_stage_hunk,
        '󰤘 GitSigns: Undo staged hunk'
      )
    end,
  },
}
