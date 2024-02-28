local function configureScala(self, opts)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = self.ft,
    callback = function()
      require('metals').initialize_or_attach(opts)
    end,
  })
end

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

return {
  'scalameta/nvim-metals',
  dependencies = {
    'lang:common',
    'scalameta/nvim-metals',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = configureScala,
  cond = function()
    return vim.fn.executable('metals') == 1
  end,
  ft = { 'scala', 'sbt', 'java' },
  opts = getScalaOpts,
  config = configureScala,
}
