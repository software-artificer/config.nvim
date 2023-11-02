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
          ['<esc>'] = actions.close,
          ['<c-n>'] = actions.move_selection_next,
          ['<c-p>'] = actions.move_selection_previous,
          ['<cr>'] = actions.select_default,
          ['<c-u>'] = actions.preview_scrolling_up,
          ['<c-d>'] = actions.preview_scrolling_down,
          -- only in master, will be available in 0.10.x
          --['<c-f>'] = actions.preview_scrolling_left,
          --['<c-b>'] = actions.preview_scrolling_right,
        },
      },
      layout_strategy = 'vertical',
    },
  })

  local function set_keymap(keymap, desc, action, opts)
    vim.keymap.set('n', keymap, function()
      action(opts or {})
    end, { desc = desc })
  end

  -- find files
  set_keymap('<leader>ff', 'Telescope: files, exclude ignored', function()
    pickers.find_files({ hidden = true })
  end)
  -- open buffers
  set_keymap('<leader>fb', 'Telescope: buffers', pickers.buffers)
  -- find all files, including ignored
  set_keymap(
    '<leader>fF',
    'Telescope: files, include ignored',
    pickers.find_files,
    { hidden = true, no_ignore = true }
  )
  -- find text
  set_keymap('<leader>ft', 'Telescope: live [t]ext grep', pickers.live_grep)
  -- open previous picker
  set_keymap(
    '<leader>fp',
    'Telescope: resume [p]revious picker',
    pickers.resume
  )
  -- find in current buffer
  set_keymap(
    '<leader>fc',
    'Telescope: [c]urrent buffer fuzzy find',
    pickers.current_buffer_fuzzy_find
  )
  -- navigate the jumplist
  set_keymap('<leader>fj', 'Telescope: [j]umplist', pickers.jumplist)
  -- list workspace/document diagnostic messages (problems)
  set_keymap(
    '<leader>fD',
    'Telescope: workspace [d]iagnostic',
    pickers.diagnostics
  )
  set_keymap('<leader>fd', 'Telescope: buffer [d]iagnostics', function()
    pickers.diagnostics({ bufnr = 0 })
  end)
  -- list all workspace/document symbols
  set_keymap(
    '<leader>fS',
    'Telescope: workspace [s]ymbols',
    pickers.lsp_workspace_symbols
  )
  set_keymap(
    '<leader>fs',
    'Telescope: document [s]ymbols',
    pickers.lsp_document_symbols
  )
  -- list all implementations for the method under the cursor
  set_keymap(
    '<leader>fi',
    'Telescope: [i]mplementations',
    pickers.lsp_implementations,
    { jump_type = 'never' }
  )
  -- list all references
  set_keymap(
    '<leader>fr',
    'Telescope: [r]eferences',
    pickers.lsp_references,
    { jump_type = 'never' }
  )
  -- show keymap help
  set_keymap('<leader>fk', 'Telescope: show [k]eymaps', pickers.keymaps)
end

return {
  'nvim-telescope/telescope.nvim',
  version = '^0.1',
  config = initTelescope,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
