vim.wo.number = true
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.showbreak = '󱞩 '
vim.o.cursorline = true

local function setupTheme()
  require('tokyonight').setup({
    on_highlights = function(highlights, colors)
      highlights.CursorLineNr = { fg = colors.dark5, bold = true }
      highlights.LineNr = { fg = colors.dark3 }
    end
  })

  vim.cmd.colorscheme('tokyonight-night')
end

return {
  'folke/tokyonight.nvim',
  tag = 'v2.8.0',
  config = setupTheme,
}
