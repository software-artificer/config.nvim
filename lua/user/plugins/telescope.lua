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
          -- only in master, will be available in a future release
          -- ['<c-f>'] = actions.preview_scrolling_left,
          -- ['<c-b>'] = actions.preview_scrolling_right,
        },
      },
      layout_strategy = 'vertical',
    },
    pickers = {
      buffers = {
        mappings = {
          i = { ['<c-r>'] = actions.delete_buffer },
        },
      },
    },
  })
end

local function find_files()
  require('telescope.builtin').find_files({ hidden = true })
end

local function show_open_buffers()
  require('telescope.builtin').buffers()
end

local function find_files_including_ignored()
  require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end

local function live_grep()
  require('telescope.builtin').live_grep()
end

local function open_last_picker()
  require('telescope.builtin').resume()
end

local function live_grep_current_buffer()
  require('telescope.builtin').current_buffer_fuzzy_find()
end

local function show_jumplist()
  require('telescope.builtin').jumplist()
end

local function show_workspace_diagnostic()
  require('telescope.builtin').diagnostics()
end

local function show_buffer_diagnostic()
  require('telescope.builtin').diagnostics({ bufnr = 0 })
end

local function lsp_show_workspace_symbols()
  require('telescope.builtin').lsp_workspace_symbols()
end

local function lsp_show_document_symbols()
  require('telescope.builtin').lsp_document_symbols()
end

local function lsp_show_references()
  require('telescope.builtin').lsp_references({ jump_type = 'never' })
end

local function lsp_show_implementations()
  require('telescope.builtin').lsp_implementations({ jump_type = 'never' })
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
  keys = {
    {
      '<leader>fr',
      lsp_show_references,
      mode = { 'n', 'v' },
      desc = 'Telescope: LSP - Show [r]eferences',
    },
    {
      '<leader>fi',
      lsp_show_implementations,
      mode = { 'n', 'v' },
      desc = 'Telescope: LSP - Show [i]mplementations',
    },
    {
      '<leader>fs',
      lsp_show_document_symbols,
      mode = 'v',
      desc = 'Telescope: LSP - Show document [s]ymbols',
    },
    {
      '<leader>fS',
      lsp_show_workspace_symbols,
      mode = { 'n', 'v' },
      desc = 'Telescope: LSP - Show workspace [s]ymbols',
    },
    {
      '<leader>ff',
      find_files,
      mode = 'n',
      desc = 'Telescope: find [f]iles, exclude ignored',
    },
    {
      '<leader>fF',
      find_files_including_ignored,
      mode = 'n',
      desc = 'Telescope: find [f]iles, include ignored',
    },
    {
      '<leader>fb',
      show_open_buffers,
      mode = { 'n', 'v' },
      desc = 'Telescope: Show open [b]uffers',
    },
    {
      '<leader>ft',
      live_grep,
      mode = { 'n', 'v' },
      desc = 'Telescope: Live [t]ext grep',
    },
    {
      '<leader>fp',
      open_last_picker,
      mode = { 'n', 'v' },
      desc = 'Telescope: resume [p]revious picker',
    },
    {
      '<leader>fc',
      live_grep_current_buffer,
      mode = { 'n', 'v' },
      desc = 'Telescope: [c]urrent buffer fuzzy find',
    },
    {
      '<leader>fd',
      show_buffer_diagnostic,
      mode = { 'n', 'v' },
      desc = 'Telescope: Show buffer [d]iagnostics',
    },
    {
      '<leader>fD',
      show_workspace_diagnostic,
      mode = { 'n', 'v' },
      desc = 'Telescope: Show workspace [d]iagnostic',
    },
    {
      '<leader>fj',
      show_jumplist,
      mode = { 'n', 'v' },
      desc = 'Telescope: Show [j]umplist',
    },
  },
}
