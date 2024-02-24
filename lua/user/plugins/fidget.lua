return {
  'j-hui/fidget.nvim',
  version = '^1.4',
  event = 'LspAttach',
  opts = {
    progress = {
      display = {
        done_icon = '',
        progress_icon = {
          pattern = { '󰔟', '󱦟', '󱦠' },
          period = 0.5,
        },
      },
    },
    notification = { view = { group_separator = '  ' } },
  },
}
