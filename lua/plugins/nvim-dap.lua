return {
  'mfussenegger/nvim-dap',
  version = '^0.10',
  -- which-key is not a dependency of nvim-dap, but we are using it here to
  -- add custom mapping with nice descriptions.
  dependencies = { 'folke/which-key.nvim' },
  config = function(_, opts)
    vim.fn.sign_define(
      'DapBreakpoint',
      { texthl = 'DapBreakpoint', text = '󰓛' }
    )
    vim.fn.sign_define(
      'DapBreakpointCondition',
      { texthl = 'DapBreakpoint', text = '' }
    )
    vim.fn.sign_define(
      'DapBreakpointRejected',
      { texthl = 'DapBreakpoint', text = '' }
    )

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dap-float',
      callback = function(args)
        local wk = require('which-key')
        for _, keymap in next, { 'q', 'Q', '<leader>q', '<leader>Q' } do
          wk.add({
            keymap,
            function()
              vim.api.nvim_win_close(0, true)
            end,
            mode = 'n',
            buffer = args.buf,
            desc = 'Debug: Close the hover window',
            icon = { icon = '', color = 'yellow' },
          })
        end
      end,
    })

    require('dap')
  end,
  keys = {
    {
      '<leader>bBc',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'Debug: Set conditional breakpoint',
    },
    {
      '<leader>bBC',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Debug: Clear all breakpoints',
    },
    {
      '<leader>bBl',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'Debug: List breakpoints',
    },
    {
      '<leader>bb',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle current line breakpoint',
    },
    {
      '<leader>bc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Run the program or continue execution',
    },
    {
      '<leader>ba',
      function()
        require('dap').continue({ before = get_args })
      end,
      desc = 'Debug with arguments',
    },
    {
      '<leader>bC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Run the program until cursor',
    },
    {
      '<leader>bl',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step into',
    },
    {
      '<leader>bh',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step out',
    },
    {
      '<leader>bo',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step over',
    },
    {
      '<leader>bk',
      function()
        require('dap').up()
      end,
      desc = 'Debug: Go up the stack trace without stepping',
    },
    {
      '<leader>bj',
      function()
        require('dap').down()
      end,
      desc = 'Debug: Go down the stack trace without stepping',
    },
    {
      '<leader>bl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Re-run the debugging session',
    },
    {
      '<leader>bp',
      function()
        require('dap').pause()
      end,
      desc = 'Debug: Pause a thread',
    },
    {
      '<leader>br',
      function()
        require('dap').repl.toggle()
      end,
      desc = 'Debug: Toggle the REPL window',
    },
    {
      '<leader>bq',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate the session',
    },
    {
      '<leader>bK',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'Debug: Evaluate the symbol under the cursor',
    },
  },
}
