return {
  'folke/flash.nvim',
  version = '^2.1',
  event = 'VeryLazy',
  opts = {
    labels = 'arstdhneioqwpgjluyzxcvbkm',
    modes = {
      char = {
        label = { exclude = 'hjkliardcs' },
      },
      search = { enabled = true },
    },
  },
}
