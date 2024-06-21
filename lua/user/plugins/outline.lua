local function setupPlugin(_, opts)
  local outline = require('outline')

  outline.setup(opts)

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'Outline',
    callback = function(opts)
      keymap_set(
        'n',
        { 'q', '<esc>', '<leader>q', '<leader>Q' },
        outline.close_outline,
        { desc = 'Symbols Outline: 󰩈 [Q]uit the outline', buffer = opts.buf }
      )
      keymap_set('n', '<cr>', function()
        outline._sidebar_do('_goto_location', { false })
      end, {
        desc = 'Symbols Outline:  Peek symbol',
        buffer = opts.buf,
      })
      keymap_set('n', '<c-cr>', function()
        outline._sidebar_do('_goto_and_close')
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline:  Jump to symbol',
      })
      keymap_set('n', ',', function()
        outline._sidebar_do('_set_folded', { true })
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline:  Expand the current fold',
      })
      keymap_set('n', '.', function()
        outline._sidebar_do('_set_folded', { false })
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline:  Collapse the current fold',
      })
      keymap_set('n', '<', function()
        outline._sidebar_do('_set_all_folded', { true })
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline: 󰪴 Expand all folds',
      })
      keymap_set('n', '>', function()
        outline._sidebar_do('_set_all_folded', { false })
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline: 󰪦 Collapse all folds',
      })
      keymap_set('n', { 'v', 'V' }, function() end, { buffer = opts.buf })
    end,
  })
end

return {
  'hedyhli/outline.nvim',
  version = "^1",
  config = setupPlugin,
  opts = {
    keymaps = {
      show_help = {},
      close = {},
      goto_location = {},
      peek_location = {},
      goto_and_close = {},
      restore_location = {},
      hover_symbol = {},
      toggle_preview = {},
      rename_symbol = {},
      code_actions = {},
      fold = {},
      unfold = {},
      fold_toggle = {},
      fold_toggle_all = {},
      fold_all = {},
      unfold_all = {},
      fold_reset = {},
      down_and_jump = {},
      up_and_jump = {},
    },
    lsp_blacklist = {
      'null-ls',
    },
  },
  keys = {
    {
      '<leader>o',
      function()
        require('outline').toggle_outline()
      end,
      mode = { 'n', 'v' },
      desc = '󱏒 Symbols [o]utline',
    },
  },
}
