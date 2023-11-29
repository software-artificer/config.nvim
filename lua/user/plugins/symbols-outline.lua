local function setupPlugin(_, opts)
  local outline = require('symbols-outline')

  outline.setup(opts)

  local function goto_location()
    local node = outline._current_node()
    vim.api.nvim_win_set_cursor(
      outline.state.code_win,
      { node.line + 1, node.character }
    )
    vim.fn.win_gotoid(outline.state.code_win)
    outline.close_outline()
  end

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'Outline',
    callback = function(opts)
      keymap_set(
        'n',
        { 'q', '<esc>', '<leader>q' },
        outline.close_outline,
        { desc = 'Symbols Outline: 󰩈 [Q]uit the outline', buffer = opts.buf }
      )
      keymap_set('n', '<cr>', goto_location, {
        desc = 'Symbols Outline:  Jump to symbol',
        buffer = opts.buf,
      })
      keymap_set('n', ',', function()
        outline._set_folded(true)
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline:  Expand the current fold',
      })
      keymap_set('n', '.', function()
        outline._set_folded(false)
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline:  Collapse the current fold',
      })
      keymap_set('n', '<', function()
        outline._set_all_folded(true)
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline: 󰪴 Expand all folds',
      })
      keymap_set('n', '>', function()
        outline._set_all_folded(false)
      end, {
        buffer = opts.buf,
        desc = 'Symbols Outline: 󰪦 Collapse all folds',
      })
      keymap_set('n', { 'v', 'V' }, function() end, { buffer = opts.buf })
    end,
  })
end

return {
  'simrat39/symbols-outline.nvim',
  config = setupPlugin,
  opts = {
    keymaps = {
      close = {},
      goto_location = {},
      focus_location = {},
      hover_symbol = {},
      toggle_preview = {},
      rename_symbol = {},
      code_actions = {},
      show_help = {},
      fold = {},
      unfold = {},
      fold_all = {},
      unfold_all = {},
      fold_reset = {},
    },
    symbols = {
      File = { icon = '', hl = '@text.uri' },
      Module = { icon = '󰕳', hl = '@namespace' },
      Namespace = { icon = '󰌗', hl = '@namespace' },
      Package = { icon = '', hl = '@namespace' },
      Class = { icon = '', hl = '@type' },
      Method = { icon = '󰰐', hl = '@method' },
      Property = { icon = '', hl = '@method' },
      Field = { icon = '', hl = '@field' },
      Constructor = { icon = '󱥉', hl = '@constructor' },
      Enum = { icon = '', hl = '@type' },
      Interface = { icon = '', hl = '@type' },
      Function = { icon = '󰊕', hl = '@function' },
      Variable = { icon = '󱄑', hl = '@constant' },
      Constant = { icon = '󰏿', hl = '@constant' },
      String = { icon = '󰀬', hl = '@string' },
      Number = { icon = '󰎠', hl = '@number' },
      Boolean = { icon = '◩', hl = '@boolean' },
      Array = { icon = '󰅪', hl = '@constant' },
      Object = { icon = '󰅩', hl = '@type' },
      Key = { icon = '󰌋', hl = '@type' },
      Null = { icon = '󰟢', hl = '@type' },
      EnumMember = { icon = '', hl = '@field' },
      Struct = { icon = '', hl = '@type' },
      Event = { icon = '', hl = '@type' },
      Operator = { icon = '', hl = '@operator' },
      TypeParameter = { icon = '', hl = '@parameter' },
      Component = { icon = '󰅴', hl = '@function' },
      Fragment = { icon = '', hl = '@constant' },
    },
    lsp_blacklist = {
      'null-ls',
    },
  },
  keys = {
    {
      '<leader>o',
      function()
        require('symbols-outline').toggle_outline()
      end,
      mode = { 'n', 'v' },
      desc = '󱏒 Symbols [o]utline',
    },
  },
}
