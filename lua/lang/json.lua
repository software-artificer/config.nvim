local have_jsonls = vim.fn.executable('vscode-json-language-server') == 1

return {
  name = 'lang:json',
  cond = have_jsonls,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/json/',
  config = function()
    vim.lsp.enable('jsonls')
  end,
}
