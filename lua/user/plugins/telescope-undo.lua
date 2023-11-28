local function actions()
  return require('telescope-undo.actions')
end

local function action_yank_additions(...)
  return actions().yank_additions(...)
end

local function action_yank_deletions(...)
  return actions().yank_deletions(...)
end

local function action_restore(...)
  return actions().restore(...)
end

local function telescope_undo()
  require('telescope').extensions.undo.undo()
end

local function setupPlugin(_, opts)
  local telescope = require('telescope')

  telescope.setup(opts)
  telescope.load_extension('undo')
end

return {
  'debugloop/telescope-undo.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = setupPlugin,
  opts = {
    extensions = {
      undo = {
        use_delta = true,
        mappings = {
	  i = {
	    ['<cr>'] = action_restore,
	    ['<c-y>'] = action_yank_additions,
	    ['<c-r>'] = action_yank_deletions,
	  },
        },
      },
    },
  },
  keys = {
    {
      '<leader>u',
      telescope_undo,
      mode = { 'n', 'v' },
      desc = '󱀼 Telescope: show [u]ndo history',
    },
  },
}
