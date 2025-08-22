local have_lsp = vim.fn.executable('lua-language-server') == 1
local have_stylua = vim.fn.executable('stylua') == 1

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set proper identation for Lua files',
  group = 'IndentSize',
  pattern = { 'lua' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

return {
  name = 'lang:lua',
  cond = have_lsp or have_stylua,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/lua/',
  config = function(_, opts)
    if opts.enable_lsp then
      -- This config is copied from lspconfig docs to enable NeoVim integration
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              and (
                vim.uv.fs_stat(path .. '/.luarc.json')
                or vim.uv.fs_stat(path .. '/.luarc.jsonc')
              )
            then
              return
            end
          end

          client.config.settings.Lua =
            vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' },
              },
            })
        end,
        settings = { Lua = { format = { enable = false } } },
      })

      vim.lsp.enable('lua_ls')
    end

    if opts.enable_formatting then
      local none_ls = require('null-ls')
      none_ls.register(none_ls.builtins.formatting.stylua)
    end
  end,
  opts = {
    enable_lsp = have_lsp,
    enable_formatting = have_stylua,
  },
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvimtools/none-ls.nvim',
  },
}
