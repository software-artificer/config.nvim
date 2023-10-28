local namespace = ...

local function find_lsp_module_directory()
    local my_directory = debug.getinfo(1, 'S').source:sub(2)

    for _, path in next, vim.api.nvim_get_runtime_file('', false) do
        if my_directory:sub(1, path:len()) == path then
            return my_directory:sub(path:len() + 1, -9)
        end
    end
end

local function load_lsp_modules(lspconfig, opts)
    for _, module_path in
        next,
        vim.api.nvim_get_runtime_file(
            find_lsp_module_directory() .. '*.lua',
            true
        )
    do
        local basename = vim.fs.basename(module_path)
        if basename ~= 'init.lua' then
            local module = require(namespace .. '.' .. basename:sub(1, -5))
            module(lspconfig, opts)
        end
    end
end

local function configLsp()
    local lspconfig = require('lspconfig')

    -- Enable cmp-nvim-lsp capabilities for LSPs
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local lsp_defaults = lspconfig.util.default_config
    lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        cmp_nvim_lsp.default_capabilities()
    )

    -- Enable formatting using LSP
    local lsp_format = require('lsp-format')
    lsp_format.setup({
        sync = true,
    })
    local on_attach = function(client, bufnr)
        lsp_format.on_attach(client, bufnr)
    end

    -- Load all LSP drop-in configurations
    load_lsp_modules(lspconfig, { on_attach = on_attach })
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'lukas-reineke/lsp-format.nvim',
        },
        config = configLsp,
    },
    {
        'lukas-reineke/lsp-format.nvim',
        tag = 'v2.6.3',
    },
}
