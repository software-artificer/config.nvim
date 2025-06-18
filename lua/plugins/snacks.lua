return {
  'folke/snacks.nvim',
  version = '^2.22',
  opts = {
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<C-o>'] = { '', mode = { 'i' } },
            ['<C-r>'] = { '', mode = { 'i' } },
          },
        },
      },
    },
  },
  priority = 1000,
  keys = {
    {
      '<leader>ff',
      function()
        Snacks.picker.files({ cmd = 'fd', hidden = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Find [f]iles in the project',
    },
    {
      '<leader>fF',
      function()
        Snacks.picker.files({ cmd = 'fd', hidden = true, ignored = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Find [f]iles in the project including ignored',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers({ current = false })
      end,
      mode = { 'n', 'v' },
      desc = 'List open [b]uffers',
    },
    {
      '<leader>ft',
      function()
        Snacks.picker.grep({ cmd = 'rg', hidden = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Full [t]ext search',
    },
    {
      '<leader>fT',
      function()
        Snacks.picker.grep({ cmd = 'rg', hidden = true, ignored = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Full [t]ext search including ignored',
    },
  },
}
