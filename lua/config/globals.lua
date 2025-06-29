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

-- Show line numbers
vim.wo.number = true
-- Make sure that long lines that break are indented appropriately
vim.o.breakindent = true
-- Display a line break icon
vim.o.showbreak = '󱞩 '
-- Highlight the line where the cursor is positioned
vim.o.cursorline = true
-- Use a better fill character for diff views
vim.o.fillchars = 'diff:'

-- Configure diagnostic options
vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = true,
})
