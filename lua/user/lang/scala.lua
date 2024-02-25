return function(_, lspconfig, lsp_opts)
  if vim.fn.executable('metals') ~= 1 then
    return
  end

  lspconfig.metals.setup(vim.tbl_deep_extend('force', lsp_opts or {}, {
    settings = {
      ['metals'] = {},
    },
  }))
end
