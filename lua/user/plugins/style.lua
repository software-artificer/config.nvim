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
      highlights.LightBulbSign = { fg = colors.yellow }

      -- color scheme for nvim-cmp
      --highlights.CmpItemAbbrDeprecated = {}
      --highlights.CmpItemAbbrMatch = {}
      --highlights.CmpItemAbbrMatchFuzzy = {}
      --highlights.CmpItemKindClass = {}
      --highlights.CmpItemKindColor = {}
      --highlights.CmpItemKindConstant = {}
      --highlights.CmpItemKindConstructor = {}
      --highlights.CmpItemKindEnum = {}
      --highlights.CmpItemKindEnumMember = {}
      --highlights.CmpItemKindEvent = {}
      --highlights.CmpItemKindField = {}
      --highlights.CmpItemKindFile = {}
      --highlights.CmpItemKindFolder = {}
      --highlights.CmpItemKindFunction = {}
      --highlights.CmpItemKindInterface = {}
      --highlights.CmpItemKindKeyword = {}
      --highlights.CmpItemKindMethod = {}
      --highlights.CmpItemKindModule = {}
      --highlights.CmpItemKindOperator = {}
      --highlights.CmpItemKindProperty = {}
      --highlights.CmpItemKindReference = {}
      --highlights.CmpItemKindSnippet = {}
      --highlights.CmpItemKindStruct = {}
      --highlights.CmpItemKindText = { bg = colors.magenta, fg = colors.bg_dark }
      --highlights.CmpItemKindTypeParameter = {}
      --highlights.CmpItemKindUnit = {}
      --highlights.CmpItemKindValue = {}
      --highlights.CmpItemKindVariable = {}
      --highlights.CmpItemMenu = {}
      highlights.Pmenu = { bg = colors.bg_dark }
      highlights.PmenuSel = { bg = colors.bg_highlight, fg = colors.fg }
    end,
  })

  vim.cmd.colorscheme('tokyonight-night')
  vim.fn.sign_define(
    'DiagnosticSignError',
    { texthl = 'DiagnosticSignError', text = '' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { texthl = 'DiagnosticSignWarn', text = '' }
  )
  vim.fn.sign_define(
    'DiagnosticSignOk',
    { texthl = 'DiagnosticSignOk', text = '' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { texthl = 'DiagnosticSignInfo', text = '' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { texthl = 'DiagnosticSignHint', text = '' }
  )
end

return {
  'folke/tokyonight.nvim',
  version = '^2.8',
  config = setupTheme,
}
