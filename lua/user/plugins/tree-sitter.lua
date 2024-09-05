return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '^0.9.2',
  opts = {
    sync_install = false,
    auto_install = true,
    -- FIXME: HTML currently crashing NeoVim
    ignore_install = { 'html' },
    highlight = {
      enable = true,
    },
    additional_vim_regex_highlighting = false,
    ident = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = false,
        node_incremental = '<leader>w',
        node_decremental = '<leader>b',
        scope_incremental = '<leader>h',
      },
    },
  },
  main = 'nvim-treesitter.configs',
  keys = {
    {
      '<leader>v',
      function()
        require('nvim-treesitter.incremental_selection').init_selection()
      end,
      mode = { 'n' },
      desc = '󰾂 TreeSitter: start incremental selection',
    },
  },
}
