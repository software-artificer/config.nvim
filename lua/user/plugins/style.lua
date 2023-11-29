vim.wo.number = true
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.showbreak = '󱞩 '
vim.o.cursorline = true

local function setupTheme()
  require('tokyonight').setup({
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

      highlights.WinBarBackground = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsFile = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsModule = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsNamespace =
        { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsPackage = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsClass = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsMethod = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsProperty = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsField = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsConstructor =
        { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsEnum = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsInterface =
        { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsFunction = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsVariable = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsConstant = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsString = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsNumber = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsBoolean = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsArray = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsObject = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsKey = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsNull = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsEnumMember =
        { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsStruct = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsEvent = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsOperator = { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicIconsTypeParameter =
        { bg = colors.bg_dark, fg = colors.blue7 }
      highlights.NavicText = { fg = colors.dark5, bg = colors.bg_dark }
      highlights.NavicSeparator = { fg = colors.fg_gutter, bg = colors.bg_dark }
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
