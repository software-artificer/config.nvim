local function setupPlugin()
  require('gitlinker').setup({
    mappings = nil,
    action_callback = print,
  })
end

local function gitLineLink()
  require('gitlinker').get_buf_range_url('n')
end

local function gitBlockLink()
  require('gitlinker').get_buf_range_url('v')
end

return {
  'ruifm/gitlinker.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = setupPlugin,
  keys = {
    {
      '<leader>gl',
      gitLineLink,
      mode = 'n',
      desc = '󰴝 GitLinker: copy link to the current line',
    },
    {
      '<leader>gl',
      gitBlockLink,
      mode = { 'v', 'x' },
      desc = '󰴜 GitLinker: copy link to the selected block',
    },
  },
}
