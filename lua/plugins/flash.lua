return {
  'folke/flash.nvim',
  version = '^2.1',
  event = 'VeryLazy',
  opts = {
    labels = 'arstdhneioqwpgjluyzxcvbkm',
    modes = {
      char = { label = { exclude = 'hjkliardcs' }, autohide = true },
      search = { enabled = true, multi_window = false },
    },
  },
}
