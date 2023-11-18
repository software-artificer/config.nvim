return {
  'lewis6991/gitsigns.nvim',
  version = '^0.6',
  opts = {
    signs = {
      untracked = { text = '󰇙' },
    },
    current_line_blame_formatter = '<author_time:%Y-%m-%d at %H:%M:%S> by <author>: <summary>',
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      keymap_set(
        { 'n', 'v' },
        '<leader>gb',
        gitsigns.toggle_current_line_blame,
        { buffer = bufnr, desc = '󰋇 GitSigns: Enable current line blame' }
      )
      keymap_set('n', '<leader>gB', function()
        gitsigns.blame_line({ full = true })
      end, {
        buffer = bufnr,
        desc = '󰋇 GitSigns: Show blame for line under the cursor',
      })
      keymap_set(
        'n',
        '<leader>gp',
        gitsigns.preview_hunk_inline,
        { buffer = bufnr, desc = ' GitSigns: Preview hunk inline' }
      )
      keymap_set(
        'n',
        '<leader>gP',
        gitsigns.preview_hunk,
        { buffer = bufnr, desc = ' GitSigns: Preview hunk' }
      )
      keymap_set(
        'n',
        '<leader>gd',
        gitsigns.toggle_deleted,
        { buffer = bufnr, desc = '󱀸 GitSigns: Toggle deleted lines' }
      )
      keymap_set(
        'n',
        '<leader>gs',
        gitsigns.stage_hunk,
        { buffer = bufnr, desc = ' GitSigns: Stage hunk' }
      )
      keymap_set('v', '<leader>gs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { buffer = bufnr, desc = '󰐒 GitSigns: Stage selection' })
      keymap_set(
        'n',
        '<leader>gr',
        gitsigns.reset_hunk,
        { buffer = bufnr, desc = ' GitSigns: Reset hunk' }
      )
      keymap_set('v', '<leader>gr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { buffer = bufnr, desc = '󰐓 GitSigns: Reset selection' })
      keymap_set({ 'n', 'v' }, '<leader>gS', gitsigns.stage_buffer, {
        buffer = bufnr,
        desc = '󱪝 GitSigns: Stage all hunks in the buffer',
      })
      keymap_set({ 'n', 'v' }, '<leader>gR', gitsigns.reset_buffer, {
        buffer = bufnr,
        desc = '󱪟 GitSigns: Reset all hunks in the buffer',
      })
      keymap_set(
        { 'n', 'v' },
        '<leader>gu',
        gitsigns.undo_stage_hunk,
        { buffer = bufnr, desc = '󰤘 GitSigns: Undo staged hunk' }
      )
    end,
  },
}
