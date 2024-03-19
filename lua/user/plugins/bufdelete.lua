return {
  'famiu/bufdelete.nvim',
  keys = {
    {
      '<leader>q',
      function() require('bufdelete').bufdelete(0, false) end,
      mode = { 'n', 'v' },
      desc = '󰩈 Bufdelete: [Q]uit the current buffer',
    },
    {
      '<leader>Q',
      function() require('bufdelete').bufdelete(0, true) end,
      mode = { 'n', 'v' },
      desc = '󰅝 Bufdelete: force-[Q]uit the current buffer',
    },
  },
}
