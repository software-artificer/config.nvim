local have_basedpyright = vim.fn.executable('basedpyright') == 1
local have_ruff = vim.fn.executable('ruff') == 1
local have_debugpy = vim.fn.executable('debugpy') == 1
  and vim.fn.executable('debugpy-adapter') == 1

return {
  name = 'lang:python',
  cond = have_basedpyright or have_ruff or have_debugpy,
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/python/',
  opts = {
    enable_debugger = have_debugpy,
    enable_lsp = have_basedpyright,
    enable_linter = have_ruff,
  },
  config = function(_, opts)
    if opts.enable_lsp then
      vim.lsp.enable('basedpyright')
    end

    if opts.enable_linter then
      vim.lsp.enable('ruff')
    end

    if opts.enable_debugger then
      local dap_python = require('dap-python')

      dap_python.setup('uv')

      local wk = require('which-key')
      vim.api.nvim_create_autocmd('filetype', {
        pattern = { 'python' },
        desc = 'add additional debugging keymaps for Python files',
        callback = function(event)
          wk.add({
            '<leader>dm',
            dap_python.test_method,
            buffer = event.buf,
            desc = 'Debug: debug the test method',
            icon = { icon = '', color = 'red' },
          })
          wk.add({
            '<leader>dt',
            dap_python.test_class,
            buffer = event.buf,
            desc = 'Debug: debug the test class',
            icon = { icon = '', color = 'red' },
          })
          wk.add({
            '<leader>ds',
            dap_python.debug_selection,
            mode = 'v',
            buffer = event.buf,
            desc = 'Debug: debug the selection',
            icon = { icon = '', color = 'red' },
          })
        end,
      })
    end
  end,
  dependencies = {
    {
      'mfussenegger/nvim-dap-python',
      dependencies = { 'mfussenegger/nvim-dap', 'folke/which-key.nvim' },
      cond = have_debugpy,
    },
  },
}
