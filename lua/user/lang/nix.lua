return function(_, lspconfig, lsp_opts)
  if vim.fn.executable('nil') ~= 1 then
    return
  end

  lspconfig.nil_ls.setup(lsp_opts or {})
end
