local function initTelescope()
    local telescope = require('telescope')
    local pickers = require('telescope.builtin')
    local actions = require('telescope.actions')
    local state = require('telescope.actions.state')
    telescope.setup({
        defaults = {
            prompt_prefix = '  ',
            selection_caret = ' ',
            multi_icon = ' ',
            default_mappings = {},
            preview = {
                tresitter = true,
            },
            file_ignore_patterns = {
                '.git',
            },
            mappings = {
                i = {
                    ['<ESC>'] = actions.close,
                    ['<C-n>'] = actions.move_selection_next,
                    ['<C-p>'] = actions.move_selection_previous,
                    ['<CR>'] = actions.select_default,
                },
            },
            layout_strategy = 'vertical',
        },
    })

    local function set_keymap(keymap, action)
        vim.keymap.set('n', keymap, action)
    end

    -- find files
    set_keymap('<leader>ff', function()
        pickers.find_files({ hidden = true })
    end)
    -- open buffers
    set_keymap('<leader>fb', pickers.buffers)
    -- find all files, including ignored
    set_keymap('<leader>fa', function()
        pickers.find_files({ hidden = true, no_ignore = true })
    end)
    -- find text
    set_keymap('<leader>ft', pickers.live_grep)
    -- open previous picker
    set_keymap('<leader>fp', pickers.resume)
    -- find in current buffer
    set_keymap('<leader>fc', pickers.current_buffer_fuzzy_find)
    -- navigate the jumplist
    set_keymap('<leader>fj', pickers.jumplist)
    --gd = pickers.lsp_definitions({jump_type = 'never'})
    --gi = pickers.lsp_implementations({jump_type = 'never'})
    --gs = pickers.lsp_workspace_symbols()
    --pickers.lsp_references()
    --pickers.diagnostics()
    --telescope.load_extension()
    --telescope.disable_all_keybindings()
end

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    config = initTelescope,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
}
