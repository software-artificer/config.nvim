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

      -- color scheme for HiPhish/rainbow-delimiters.nvim
      highlights.RainbowDelimiterRed = { fg = '#b2555b' }
      highlights.RainbowDelimiterYellow = { fg = '#e0af68' }
      highlights.RainbowDelimiterBlue = { fg = '#0db9d7' }
      highlights.RainbowDelimiterOrange = { fg = '#ff9e64' }
      highlights.RainbowDelimiterGreen = { fg = '#9ece6a' }
      highlights.RainbowDelimiterViolet = { fg = '#bb9af7' }
      highlights.RainbowDelimiterCyan = { fg = '#2ac3de' }
    end
  })

  vim.cmd.colorscheme('tokyonight-night')
end

return {
  'folke/tokyonight.nvim',
  tag = 'v2.8.0',
  config = setupTheme,
}
