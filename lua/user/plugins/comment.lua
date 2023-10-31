local function setupComment()
  require('Comment').setup({
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
  })
end

return {
  'numToStr/Comment.nvim',
  tag = 'v0.8.0',
  config = setupComment,
}
