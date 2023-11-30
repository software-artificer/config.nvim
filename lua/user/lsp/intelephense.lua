return function(lspconfig, opts)
  if vim.fn.executable('intelephense') ~= 1 then
    return
  end

  lspconfig.intelephense.setup(vim.tbl_deep_extend('force', opts or {}, {
    settings = {
      ['intelephense'] = {
        init_options = {
          licenceKey = os.getenv('INTELEPHENSE_LICENSE_KEY'),
        },
      },
    },
  }))
end
