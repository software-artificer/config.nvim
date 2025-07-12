return {
  'j-hui/fidget.nvim',
  version = '^1.6.1',
  opts = {
    progress = {
      ignore_done_already = true,
      ignore_empty_message = true,
      display = {
        render_limit = 10,
        done_icon = '',
        progress_icon = {
          pattern = { '󰔟', '󱦠', '󱦟' },
          period = 0.25,
        },
      },
    },
    notification = {
      group_separator = '-----',
    },
  },
}
