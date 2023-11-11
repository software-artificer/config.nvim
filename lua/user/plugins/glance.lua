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

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      vim.lsp.buf.definition = function()
        glance.open('definitions', {})
      end
      vim.lsp.buf.type_definition = function()
        glance.open('type_definitions', {})
      end
    end,
  })
end

return {
  'DNLHC/glance.nvim',
  config = initPlugin,
}
