return {
  'folke/tokyonight.nvim',
  version = '^4',
  lazy = false,
  priority = 1000,
  opts = {
    on_colors = function(colors)
      local util = require('tokyonight.util')

      colors.guideline_active = util.darken(colors.dark3, 0.8)
      colors.guideline = util.darken(colors.dark3, 0.3)
    end,
    on_highlights = function(highlights, colors)
      -- Line number in normal mode and under current cursor
      highlights.CursorLineNr =
        { fg = colors.fg_dark, bold = true, bg = colors.bg_highlight }
      highlights.LineNr = { fg = colors.dark3 }
      -- Guidelines
      highlights.SnacksIndent = { fg = colors.guideline }
      highlights.SnacksIndentScope = { fg = colors.guideline_active }
      highlights.SnacksIndentChunk = { fg = colors.guideline_active }
      highlights.VirtColumn = { fg = colors.guideline }
      -- GitSigns
      highlights.GitSignsAdd = { fg = colors.green1 }
      highlights.GitSignsChangedelet = { fg = colors.magenta }
      highlights.GitSignsUntracked = { fg = colors.fg_dark }
      -- TextYankPost
      highlights.TextYank = { bg = colors.magenta }
    end,
    style = 'moon',
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    vim.cmd.colorscheme('tokyonight')
  end,
}
