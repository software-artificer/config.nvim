return {
  'folke/tokyonight.nvim',
  version = '^4',
  lazy = false,
  priority = 1000,
  opts = {
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors)
      highlights.CursorLineNr =
        { fg = colors.fg_dark, bold = true, bg = colors.bg_highlight }
      highlights.LineNr = { fg = colors.dark3 }
    end,
    style = 'moon',
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    vim.cmd.colorscheme('tokyonight')
  end,
}
