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
  version = '^3.0',
  config = setupTheme,
  opts = {
    on_colors = function(colors)
      local util = require('tokyonight.util')

      colors.guideline = util.darken(colors.bg_highlight, 0.5)

      colors.dark_red = '#291919'
      colors.dark_cyan = '#293939'
      colors.dark_yellow = '#393900'
      colors.dark_green = '#193919'
      colors.dark_violet = '#302240'
      colors.dark_blue = '#1c2951'
    end,
    on_highlights = function(highlights, colors)
      highlights.CursorLineNr =
        { fg = colors.fg_dark, bold = true, bg = colors.bg_highlight }
      highlights.LineNr = { fg = colors.dark5 }

      -- color scheme for HiPhish/rainbow-delimiters.nvim
      highlights.RainbowDelimiterRed = { fg = colors.red1 }
      highlights.RainbowDelimiterCyan = { fg = colors.cyan }
      highlights.RainbowDelimiterYellow = { fg = colors.yellow }
      highlights.RainbowDelimiterGreen = { fg = colors.green }
      highlights.RainbowDelimiterViolet = { fg = colors.purple }
      highlights.RainbowDelimiterBlue = { fg = colors.blue0 }

      -- LightBulb color style
      highlights.LightBulbSign = { fg = colors.yellow }

      -- Virtual column delimiter
      highlights.VirtColumn = { fg = colors.guideline, bg = colors.none }

      -- Ident virtual rulers
      highlights.RainbowRed = { fg = colors.dark_red }
      highlights.RainbowBlue = { fg = colors.dark_blue }
      highlights.RainbowYellow = { fg = colors.dark_yellow }
      highlights.RainbowViolet = { fg = colors.dark_violet }
      highlights.RainbowGreen = { fg = colors.dark_green }
      highlights.RainbowCyan = { fg = colors.dark_cyan }

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
