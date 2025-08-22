local have_nil = vim.fn.executable('nil') == 1
local have_nixfmt = vim.fn.executable('nixfmt') == 1

return {
  name = 'lang:nix',
  cond = have_nil or have_nixfmt,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/nix/',
  opts = {
    enable_lsp = have_nil,
    enable_formatter = have_nixfmt,
  },
  config = function(_, opts)
    local formatting = {}
    if opts.enable_formatter then
      formatting.command = { 'nixfmt' }
    end

    if opts.enable_lsp then
      vim.lsp.config('nil_ls', {
        settings = {
          ['nil'] = { formatting = formatting },
        },
      })

      vim.lsp.enable('nil_ls')
    end
  end,
  dependencies = {
    'neovim/nvim-lspconfig',
  },
}
