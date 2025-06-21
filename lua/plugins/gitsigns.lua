return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'folke/which-key.nvim' },
  version = '^1.0.2',
  opts = {
    signs = {
      untracked = '┃',
    },
    signs_staged = {
      untracked = '┃',
    },
    attach_to_untracked = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
    },
    current_line_blame_formatter = '<author_time:%Y-%m-%d at %H:%M:%S> by <author>: <summary>',
    on_attach = function(bufnr)
      local wk = require('which-key')
      local gitsigns = require('gitsigns')

      wk.add({
        ']c',
        function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end,
        mode = 'n',
        buffer = bufnr,
        desc = 'Go to next [c]hange',
        icon = { icon = '󰮱', color = 'yellow' },
      })

      wk.add({
        '[c',
        function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end,
        mode = 'n',
        buffer = bufnr,
        desc = 'Go to previous [c]hange',
        icon = { icon = '󰮳', color = 'yellow' },
      })

      wk.add({
        '<leader>hs',
        gitsigns.stage_hunk,
        mode = 'n',
        buffer = bufnr,
        desc = '[S]tage current [h]unk',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hs',
        function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        mode = 'v',
        buffer = bufnr,
        desc = '[S]tage selection',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hS',
        gitsigns.stage_buffer,
        mode = { 'n', 'v' },
        buffer = bufnr,
        desc = '[S]tage all [h]unks in the buffer',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hr',
        gitsigns.reset_hunk,
        mode = 'n',
        buffer = bufnr,
        desc = '[R]reset current [h]unk',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hr',
        function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        mode = 'n',
        buffer = bufnr,
        desc = '[R]reset selection',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hR',
        gitsigns.reset_buffer,
        mode = { 'n', 'v' },
        buffer = bufnr,
        desc = '[R]eset all [h]unks in the buffer',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hp',
        gitsigns.preview_hunk_inline,
        mode = 'n',
        buffer = bufnr,
        desc = 'Show inline [p]review for current hunk',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hP',
        gitsigns.preview_hunk,
        mode = 'n',
        buffer = bufnr,
        desc = '[P]review changes for the current [h]unk',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hB',
        function()
          gitsigns.blame_line({ full = true })
        end,
        mode = 'n',
        buffer = bufnr,
        desc = '[B]lame the current line',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>hd',
        gitsigns.diffthis,
        mode = 'n',
        buffer = bufnr,
        desc = '',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<leader>gB',
        gitsigns.toggle_current_line_blame,
        mode = 'n',
        buffer = bufnr,
        desc = 'Toggle current line [b]lame',
        icon = { icon = '', color = 'yellow' },
      })
    end,
  },
}
