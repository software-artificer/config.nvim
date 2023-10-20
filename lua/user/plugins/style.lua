return {
  'folke/tokyonight.nvim',
  tag = 'v2.8.0',
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme('tokyonight')
  end,
}
