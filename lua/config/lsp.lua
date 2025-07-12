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

local wk = require('which-key')
local inc_rename = require('inc_rename')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if client.server_capabilities.definitionProvider then
      wk.add({
        'gd',
        vim.lsp.buf.definition,
        mode = 'n',
        buffer = event.buf,
        desc = 'Go to definition',
        icon = { icon = '', color = 'orange' },
      })
    end

    if client.server_capabilities.declarationProvider then
      wk.add({
        'gD',
        vim.lsp.buf.declaration,
        mode = 'n',
        buffer = event.buf,
        desc = 'Go to declaration',
        icon = { icon = '', color = 'orange' },
      })
    end

    if client.server_capabilities.workspaceSymbolProvider then
      wk.add({
        '<leader>fS',
        vim.lsp.buf.workspace_symbol,
        mode = 'n',
        buffer = event.buf,
        desc = '[F]ind workspace [s]ymbols',
        icon = { icon = '󱊓', color = 'orange' },
      })
    end

    if client.server_capabilities.documentSymbolProvider then
      wk.add({
        '<leader>fs',
        vim.lsp.buf.document_symbol,
        mode = 'n',
        buffer = event.buf,
        desc = '[F]ind document [s]ymbols',
        icon = { icon = '󱊓', color = 'orange' },
      })

      require('nvim-navic').attach(client, event.buf)
    end

    if client.server_capabilities.documentFormattingProvider then
      wk.add({
        '<leader>lf',
        vim.lsp.buf.format,
        mode = 'n',
        buffer = event.buf,
        desc = '[L]SP [f]ormat the document',
        icon = { icon = '', color = 'orange' },
      })
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
  end,
})
