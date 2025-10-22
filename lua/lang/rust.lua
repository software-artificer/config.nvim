local have_lsp = vim.fn.executable('rust-analyzer') == 1
local have_dap = vim.fn.executable('lldb-dap') == 1
local have_taplo = vim.fn.executable('taplo') == 1

return {
  name = 'lang:rust',
  dir = vim.fn.stdpath('config') .. '/lua/user/lang/rust/',
  opts = {
    debugger = { enabled = have_dap },
    taplo = { enabled = have_taplo },
  },
  cond = have_lsp,
  dependencies = {
    {
      'mrcjkb/rustaceanvim',
      version = '^6.5.1',
      lazy = false,
    },
    'mfussenegger/nvim-dap',
    'folke/which-key.nvim',
  },
  config = function(_, opts)
    local wk = require('which-key')
    local rust_diag = require('rustaceanvim.commands.diagnostic')

    if opts.taplo and opts.taplo.enabled then
      vim.lsp.enable('taplo')
    end

    local augroup = vim.api.nvim_create_augroup('lang:rust', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client or client.name ~= 'rust-analyzer' then
          return
        end

        wk.add({
          '<C-W>d',
          rust_diag.render_diagnostic_current_line,
          mode = 'n',
          buffer = event.buf,
          desc = 'Show diagnostics under the cursor',
          icon = { icon = '󱘗', color = 'black' },
        })

        wk.add({
          '<C-W><C-D>',
          '<C-W>d',
          mode = 'n',
          buffer = event.buf,
          desc = 'Show diagnostics under the cursor',
          icon = { icon = '󱘗', color = 'black' },
        })

        wk.add({
          '<leader>lme',
          require('rustaceanvim.commands.expand_macro'),
          mode = { 'n', 'v' },
          buffer = event.buf,
          desc = 'Rust: Expand Macro',
          icon = { icon = '󰁌', color = 'black' },
        })

        wk.add({
          '<leader>lmr',
          require('rustaceanvim.commands.rebuild_proc_macros'),
          mode = 'n',
          buffer = event.buf,
          desc = 'Rust: Rebuild proc macros',
          icon = { icon = '', color = 'black' },
        })

        wk.add({
          '<leader>ldr',
          rust_diag.related_diagnostics,
          mode = 'n',
          buffer = event.buf,
          desc = 'Rust: Show related diagnostics',
          icon = { icon = '', color = 'black' },
        })

        wk.add({
          '<leader>lgc',
          require('rustaceanvim.commands.open_cargo_toml'),
          mode = 'n',
          buffer = event.buf,
          desc = 'Rust: Open cargo.toml',
          icon = { icon = '', color = 'black' },
        })

        wk.add({
          '<leader>lgd',
          require('rustaceanvim.commands.external_docs'),
          mode = 'n',
          buffer = event.buf,
          desc = 'Rust: Open docs.rs',
          icon = { icon = '', color = 'black' },
        })

        wk.add({
          '<leader>lgp',
          require('rustaceanvim.commands.parent_module'),
          mode = 'n',
          buffer = event.buf,
          desc = 'Rust: Go to the parent module',
          icon = { icon = '', color = 'black' },
        })
      end,
    })

    vim.g.rustaceanvim = function()
      local dap_config = { adapter = nil }
      if opts and opts.debuger and opts.debugger.enabled then
        dap_config = {
          adapter = {
            type = 'executable',
            command = opts.debugger.lldb_path
              or vim.fn.exepath('lldb-dap')
              or 'lldb-dap',
            name = 'lldb',
          },
        }
      end

      return {
        tools = { enable_clippy = true },
        dap = dap_config,
      }
    end
  end,
}
