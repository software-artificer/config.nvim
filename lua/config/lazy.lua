-- Automatically install lazy.nvim if it is not yet installed
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then
  local lazy_repo = 'https://github.com/folke/lazy.nvim.git'
  local output = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazy_repo,
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone the lazy.nvim repository:\n', 'ErrorMsg' },
      { output, 'WarningMsg' },
      { '\nPress Q to exit or any other key to continue...' },
    }, false, {})
    local input = vim.fn.getchar()
    if input == 81 or input == 113 then
      os.exit(1)
    end
  end
end
vim.opt.rtp:prepend(lazy_path)

-- Setup lazy.nvim and plugins
require('lazy').setup({
  spec = { { import = 'plugins' } },
  pkg = { sources = { 'lazy' } },
  rocks = { enabled = false },
  install = { colorscheme = { 'tokyonight-moon' } },
  change_detection = { enabled = false },
})
