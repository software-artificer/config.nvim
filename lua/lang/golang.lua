local have_gopls = vim.fn.executable('gopls') == 1
local have_delve = vim.fn.executable('dlv') == 1
local have_golangci_lint = vim.fn.executable('golangci-lint-langserver') == 1
  and vim.fn.executable('golangci-lint') == 1

return {
  name = 'lang:golang',
  cond = have_gopls or have_golangci_lint,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/golang/',
  opts = {
    enable_debugger = have_delve,
    enable_lsp = have_gopls,
    enable_linter = have_golangci_lint,
  },
  config = function(_, opts)
    if opts.enable_lsp then
      local path = vim.uv.cwd()
      local have_wire = vim.fn.findfile('wire.go', path, 1)

      vim.print(have_wire)
      if have_wire then
        vim.lsp.config('gopls', {
          settings = { gopls = { buildFlags = { '-tags=wireinject' } } },
        })
      end

      vim.lsp.enable('gopls')
    end

    if opts.enable_linter then
      vim.lsp.enable('golangci_lint_ls')
    end

    if opts.enable_debugger then
      local dap_go = require('dap-go')

      dap_go.setup({
        delve = {
          path = 'dlv',
          initialize_timeout_sec = 20,
          port = '${port}',
        },
      })

      local wk = require('which-key')
      vim.api.nvim_create_autocmd('filetype', {
        pattern = { 'go' },
        desc = 'add delve-specific keymaps for go files',
        callback = function(event)
          wk.add({
            '<leader>dt',
            dap_go.debug_test,
            buffer = event.buf,
            desc = 'Debug: debug the test',
            icon = { icon = '', color = 'red' },
          })
          wk.add({
            '<leader>dT',
            dap_go.debug_last_test,
            buffer = event.buf,
            desc = 'Debug: debug the last test',
            icon = { icon = '', color = 'red' },
          })
        end,
      })
    end
  end,
  dependencies = {
    {
      'leoluz/nvim-dap-go',
      dependencies = { 'mfussenegger/nvim-dap', 'folke/which-key.nvim' },
      cond = have_delve,
    },
  },
}
