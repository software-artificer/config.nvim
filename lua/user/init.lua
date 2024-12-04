-- Set leader button to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Disable mouse integration
vim.opt.mouse = ''
-- Prevent NeoVim from changing window sizes when opening a new file
vim.opt.equalalways = true

-- Configure diagnostic options
vim.diagnostic.config({
  severity_sort = true,
})

function keymap_set(modes, keymaps, action, opts)
  if type(keymaps) == 'string' then
    keymaps = { keymaps }
  end

  for _, keymap in next, keymaps do
    vim.keymap.set(modes, keymap, action, opts)
  end
end

-- Install lazy.nvim plugin manager
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- Install and configure plugins
require('lazy').setup({
  spec = {
    { import = 'user.plugins' },
    { import = 'user.lang' },
  },
})

keymap_set(
  'v',
  '<leader>y',
  '"+y',
  { noremap = true, silent = true, desc = '󰅌 Copy to clipboard' }
)

keymap_set('n', '<leader>yy', '"+yy', {
  noremap = true,
  silent = true,
  desc = '󰅌 Copy current line to clipboard',
})
