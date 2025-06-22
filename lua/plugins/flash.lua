return {
  'folke/flash.nvim',
  version = '^2.1',
  event = 'VeryLazy',
  opts = {
    labels = 'arstdhneioqwpgjluyzxcvbkm',
    modes = {
      char = {
        jump_labels = true,
        label = { exclude = "hjkliardcs" },
      },
      search = { enabled = true },
    },
  },
}
