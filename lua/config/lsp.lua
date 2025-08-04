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

vim.opt.inccommand = 'split'

local inc_rename = require('inc_rename')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if
      vim.b[event.buf].hasDocumentSymbolProvider ~= true
      and client.server_capabilities.documentSymbolProvider
    then
      vim.b[event.buf].hasDocumentSymbolProvider = true

      require('nvim-navic').attach(client, event.buf)
    end

    if client.server_capabilities.codeActionProvider then
      vim.lsp.buf.code_action = require('actions-preview').code_actions
    end

    if client.server_capabilities.renameProvider then
      vim.lsp.buf.rename = function()
        vim.fn.feedkeys(
          ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
        )
      end
    end

    if
      vim.b[event.buf].hasLspCodeLensProvider ~= true
      and client.server_capabilities.codeLensProvider
    then
      vim.b[event.buf].hasLspCodeLensProvider = true
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        callback = vim.lsp.codelens.refresh,
        buffer = event.buf,
      })
    end
  end,
})
