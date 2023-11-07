return {
  'numToStr/Comment.nvim',
  version = '^0.8',
  config = setupComment,
  opts = {
    padding = true,
    sticky = true,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    mappings = nil,
  },
}
