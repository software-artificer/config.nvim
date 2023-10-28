local function initTelescope()
  local telescope = require('telescope')
  local pickers = require('telescope.builtin')
  local actions = require('telescope.actions')
  local state = require('telescope.actions.state')
  telescope.setup({
    defaults = {
      prompt_prefix = '  ',
      selection_caret = ' ',
      multi_icon = ' ',
      default_mappings = {},
      preview = {
        tresitter = true,
      },
      file_ignore_patterns = {
        '.git',
      },
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,
          ['<CR>'] = actions.select_default,
	  ['<C-u>'] = actions.preview_scrolling_up,
	  ['<C-d>'] = actions.preview_scrolling_down,
	  -- Only in master, not available in the latest release (yet)
	  --['<C-f>'] = actions.preview_scrolling_left,
	  --['<C-b>'] = actions.preview_scrolling_right,
        },
      },
      layout_strategy = 'vertical',
    },
  })

  local function set_keymap(keymap, action, opts)
    vim.keymap.set('n', keymap, function() action(opts or {}) end)
  end

  -- find files
  set_keymap('<leader>ff', function()
    pickers.find_files({ hidden = true })
  end)
  -- open buffers
  set_keymap('<leader>fb', pickers.buffers)
  -- find all files, including ignored
  set_keymap('<leader>fa', pickers.find_files, { hidden = true, no_ignore = true })
  -- find text
  set_keymap('<leader>ft', pickers.live_grep)
  -- open previous picker
  set_keymap('<leader>fp', pickers.resume)
  -- find in current buffer
  set_keymap('<leader>fc', pickers.current_buffer_fuzzy_find)
  -- navigate the jumplist
  set_keymap('<leader>fj', pickers.jumplist)
  -- list diagnostic messages (problems)
  set_keymap('<leader>fd', pickers.diagnostics)
  -- list all workspace symbols
  set_keymap('<leader>fs', pickers.lsp_workspace_symbols)
  -- list all implementations for the method under the cursor
  set_keymap('<leader>fi', pickers.lsp_implementations, { jump_type = 'never' })
  -- list all references
  set_keymap('<leader>fr', pickers.lsp_references, { jump_type = 'never' })
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  config = initTelescope,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
