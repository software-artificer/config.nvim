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

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
}
