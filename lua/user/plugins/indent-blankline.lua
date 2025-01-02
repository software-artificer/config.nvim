return {
  'lukas-reineke/indent-blankline.nvim',
  version = '^3.8',
  main = 'ibl',
  opts = {
    scope = { enabled = false },
    indent = {
      highlight = {
        'RainbowRed',
        'RainbowCyan',
        'RainbowYellow',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowBlue',
      },
    },
  },
  dependencies = { 'folke/tokyonight.nvim' },
}
