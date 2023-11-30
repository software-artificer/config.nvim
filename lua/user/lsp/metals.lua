return function(lspconfig, opts)
  if vim.fn.executable('metals') ~= 1 then
    return
  end

  lspconfig.metals.setup(vim.tbl_deep_extend('force', opts or {}, {
    settings = {
      ['metals'] = {},
    },
  }))
end
