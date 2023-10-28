return function(lspconfig, opts)
  lspconfig.rust_analyzer.setup(vim.tbl_deep_extend('force', opts or {}, {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            'cargo',
            'clippy',
            '--workspace',
            '--message-format=json',
            '--all-targets',
            '--all-features',
          },
        },
      },
    },
  }))
end
