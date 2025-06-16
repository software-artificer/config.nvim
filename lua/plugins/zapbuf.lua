return {
  dir = vim.fn.stdpath('config') .. '/lua/user/zapbuf.nvim',
  name = 'zapbuf',
  opts = {},
  keys = {
    {
      mode = { 'n', 'v' },
      '<leader>q',
      function()
        require('zapbuf').zap()
      end,
      desc = 'Close current buffer/window/tab',
    },
  },
}
