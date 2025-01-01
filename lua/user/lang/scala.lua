local function getScalaOpts()
  local metals = require('metals')

  local metals_config = metals.bare_config()

  metals_config.settings = {
    showImplicitArguments = true,
    useGlobalExecutable = true,
  }

  metals_config.init_options.statusBarProvider = 'off'
  metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

  metals_config.on_attach = function(client, bufnr)
    metals.setup_dap()

    map('n', '<leader>ws', function()
      metals.hover_worksheet()
    end)
  end

  return metals_config
end

local function setupLsp()
  local opts = getScalaOpts()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'scala', 'sbt', 'java' },
    callback = function()
      require('metals').initialize_or_attach(opts)
    end,
  })
end

local has_lsp = vim.fn.executable('metals') == 1

return {
  dependencies = function()
    local deps = {}

    if has_lsp then
      table.insert(deps, {
        'scalameta/nvim-metals',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'hrsh7th/cmp-nvim-lsp',
          'mfussenegger/nvim-dap',
        },
      })
    end

    return deps
  end,
  setup = function()
    if has_lsp then
      setupLsp()
    end
  end,
}
