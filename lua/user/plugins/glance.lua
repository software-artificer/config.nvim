local function initPlugin()
  local glance = require('glance')
  local actions = glance.actions
  local config = require('glance.config')

  local mappings = {
    preview = {
      ['<c-n>'] = actions.next,
      ['<c-p>'] = actions.previous,
      q = actions.close,
      gl = actions.enter_win('list'),
    },
    list = {
      ['<c-n>'] = actions.next,
      ['<c-p>'] = actions.previous,
      ['<cr>'] = actions.jump,
      q = actions.close,
      gl = actions.enter_win('preview'),
    },
  }

  print(vim.inspect(config.options))
  -- clear all default mappings
  config.setup({}, actions)
  for key, _ in next, config.options.mappings.list do
    if mappings.list[key] == nil then
      mappings.list[key] = false
    end
  end
  for key, _ in next, config.options.mappings.preview do
    if mappings.preview[key] == nil then
      mappings.preview[key] = false
    end
  end
  -- wipe out options because they're set by the config.setup() call
  config.options = {}

  glance.setup({
    mappings = mappings,
  })
end

return {
  'DNLHC/glance.nvim',
  config = initPlugin,
  keys = {
    {
      'gd',
      function()
        require('glance').open('definitions', {})
      end,
      mode = { 'n', 'v' },
      desc = '󰈮 Glance: LSP - Go to definitions',
    },
  },
}
