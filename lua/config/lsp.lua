vim.diagnostic.config({
  virtual_lines = false,
  underline = true,
  virtual_text = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
      end
  end,
})
