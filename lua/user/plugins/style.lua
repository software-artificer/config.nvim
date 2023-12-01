vim.wo.number = true
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.showbreak = '󱞩 '
vim.o.cursorline = true

local function setupTheme(_, opts)
  require('tokyonight').setup(opts)

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
  opts = {
    on_highlights = function(highlights, colors)
      highlights.CursorLineNr =
        { fg = colors.fg_dark, bold = true, bg = colors.bg_highlight }
      highlights.LineNr = { fg = colors.dark5 }

      -- color scheme for HiPhish/rainbow-delimiters.nvim
      highlights.RainbowDelimiterRed = { fg = colors.red }
      highlights.RainbowDelimiterYellow = { fg = colors.yellow }
      highlights.RainbowDelimiterBlue = { fg = colors.blue2 }
      highlights.RainbowDelimiterOrange = { fg = colors.orange }
      highlights.RainbowDelimiterGreen = { fg = colors.green }
      highlights.RainbowDelimiterViolet = { fg = colors.magenta }
      highlights.RainbowDelimiterCyan = { fg = colors.cyan }

      -- LightBulb color style
      highlights.LightBulbSign = { fg = colors.yellow }

      highlights.VirtColumn = { fg = colors.bg_highlight, bg = colors.none }

      highlights.IblIndent = { fg = colors.bg_highlight, bg = colors.none }

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
      --highlights.CmpItemKindStruct = { fg = colors.magenta }
      --highlights.CmpItemKindText = { bg = colors.magenta, fg = colors.bg_dark }
      --highlights.CmpItemKindTypeParameter = {}
      --highlights.CmpItemKindUnit = {}
      --highlights.CmpItemKindValue = {}
      --highlights.CmpItemKindVariable = {}
      --highlights.CmpItemMenu = {}

      highlights.Pmenu = { bg = colors.bg_dark }
      highlights.PmenuSel = { bg = colors.bg_highlight, fg = colors.fg }
    end,
  },
}
