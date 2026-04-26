local have_htmlls = vim.fn.executable('vscode-html-language-server') == 1

return {
  name = 'lang:html',
  cond = have_htmlls,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/html/',
  config = function()
    vim.lsp.enable('html')
  end,
}
