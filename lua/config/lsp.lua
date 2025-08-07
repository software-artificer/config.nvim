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
local lightbulb = require('lightbulb')
local wk = require('which-key')

local lsp_augroup =
  vim.api.nvim_create_augroup('LspEnhancements', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if
      vim.b[event.buf].hasDocumentSymbolProvider ~= true
      and client:supports_method('textDocument/documentSymbol')
    then
      vim.b[event.buf].hasDocumentSymbolProvider = true

      require('nvim-navic').attach(client, event.buf)
    end

    if client:supports_method('textDocument/codeAction') then
      vim.lsp.buf.code_action = require('actions-preview').code_actions
    end

    if client:supports_method('textDocument/rename') then
      vim.lsp.buf.rename = function()
        vim.fn.feedkeys(
          ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
        )
      end
    end

    if
      vim.b[event.buf].hasLspCodeLensProvider ~= true
      and client:supports_method('textDocument/codeLens')
    then
      vim.b[event.buf].hasLspCodeLensProvider = true
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        callback = vim.lsp.codelens.refresh,
        buffer = event.buf,
      })
    end

    if
      vim.b[event.buf].hasLspFormatting ~= true
      and not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting')
    then
      vim.b[event.buf].hasLspFormatting = true

      local disable_formatting = false

      wk.add({
        '<leader>ltf',
        function()
          disable_formatting = not disable_formatting

          local state = 'on'
          if disable_formatting then
            state = 'off'
          end

          vim.api.nvim_echo(
            { { '󰉼 LSP formatting is ' .. state, 'WarningMsg' } },
            false,
            {}
          )
        end,
        mode = 'n',
        buffer = event.buf,
        desc = 'Toggle LSP formatting on save',
        icon = { icon = '', color = 'black' },
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = lsp_augroup,
        desc = 'Format the file on save using LSP',
        buffer = event.buf,
        callback = function()
          if disable_formatting then
            return
          end

          vim.lsp.buf.format({
            bufnr = event.buf,
            id = client.id,
            timeout_ms = 1000,
          })
        end,
      })
    end
  end,
})
