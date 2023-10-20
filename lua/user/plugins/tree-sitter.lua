local function initPlugin()
  require('nvim-treesitter.configs').setup({
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    additional_vim_regex_highlighting = false,
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  tag = 'v0.9.1',
  config = initPlugin,
}
