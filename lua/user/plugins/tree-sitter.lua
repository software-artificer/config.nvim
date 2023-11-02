local function initPlugin()
  require('nvim-treesitter.configs').setup({
    sync_install = false,
    auto_install = true,
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
        init_selection = '<leader>v',
        node_incremental = 'w',
        node_decremental = 'b',
        scope_incremental = false,
      },
    },
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '^0.9',
  config = initPlugin,
}
