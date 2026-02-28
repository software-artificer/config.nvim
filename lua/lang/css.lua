local have_cssls = vim.fn.executable('vscode-css-language-server') == 1

return {
  name = 'lang:css',
  cond = have_cssls,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/css/',
  config = function(_, opts)
      vim.lsp.enable('cssls')
  end,
}
