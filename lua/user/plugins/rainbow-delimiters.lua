local function getPluginOpts()
  local rainbow_delimiters = require('rainbow-delimiters')

  return {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterCyan',
      'RainbowDelimiterYellow',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterBlue',
    },
  }
end

local function configurePlugin(self, opts)
  require('rainbow-delimiters.setup').setup(opts)
end

return {
  'HiPhish/rainbow-delimiters.nvim',
  version = '^0.8',
  opts = getPluginOpts,
  config = configurePlugin,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
