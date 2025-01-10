local has_lsp = vim.fn.executable('rust-analyzer') == 1
local has_dap = vim.fn.executable('lldb-dap') == 1

local function setupLsp()
  if not has_lsp then
    return
  end

  vim.g.rustaceanvim = {
    server = {
      on_attach = function(_, bufnr)
        keymap_set({ 'n', 'v' }, '<leader>d', function()
          vim.cmd.RustLsp('renderDiagnostic', 'current')
        end, {
          buffer = bufnr,
          silent = true,
          desc = '󱡴 LSP: Rust — render diagnostic information',
        })
      end,
    },
    tools = {
      enable_clippy = true,
      enable_nextest = false,
    },
  }
end

local function setupDap()
  local config = vim.g.rustaceanvim

  if not config then
    return
  end

  config.dap = { adapter = false }

  if has_dap then
    config.dap = {
      adapter = {
        type = 'executable',
        command = vim.fn.exepath('lldb-dap'),
        name = 'lldb',
      },
    }
  end

  vim.g.rustaceanvim = config
end

return {
  dependencies = function()
    return {
      {
        'mrcjkb/rustaceanvim',
        version = '^5',
        cond = has_lsp,
      },
    }
  end,
  setup = function()
    setupLsp()
    setupDap()
  end,
}
