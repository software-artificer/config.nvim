-- Set leader button to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Disable mouse integration
vim.opt.mouse = nil

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
        require('user.lsp'),
    },
})
