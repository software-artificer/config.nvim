-- Map leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Disable mouse integration
vim.opt.mouse = ''
-- Prevent NeoVim from changing window sizes when opening a new file
vim.opt.equalalways = true
-- Reserve the space for sign column to avoid layout jumps
vim.opt.signcolumn = 'yes:1'
-- Reserve the space for window bar to avoid layout jumps
vim.opt.winbar = ' '
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure diagnostic options
vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = true,
})

-- Load lazy plugin manager
require('config.lazy')
