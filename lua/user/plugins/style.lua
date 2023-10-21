vim.wo.number = true
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.showbreak = '󱞩 '
vim.o.cursorline = true

local function setupTheme()
  vim.cmd.colorscheme('tokyonight-night')

  local colors = require('tokyonight.colors')

  vim.api.nvim_set_hl(0, 'CursorLineNr', { bold = true, fg = colors.default.dark5 })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.default.dark3 })
end

return {
  'folke/tokyonight.nvim',
  tag = 'v2.8.0',
  config = setupTheme,
}
