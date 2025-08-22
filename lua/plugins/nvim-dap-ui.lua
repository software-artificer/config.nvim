return {
  'rcarriga/nvim-dap-ui',
  version = '^4.0.0',
  opts = {
    controls = { enabled = false },
    floating = {
      mappings = {
        close = { 'q', 'Q', '<leader>q', '<leader>Q', '<Esc>' },
      },
    },
    icons = {
      collapsed = '',
      current_frame = '',
      expanded = '',
    },
    mappings = { expand = { '<CR>', '<SPACE>' } },
  },
  config = function(_, opts)
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup(opts)

    dap.listeners.after.initialize.dapui_config = function(session)
      session.on_close.dapui_config = function()
        dapui.close()
      end
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      vim.print('launch')
      dapui.open()
    end
  end,
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
}
