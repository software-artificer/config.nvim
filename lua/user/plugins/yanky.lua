local function setupPlugin()
  local mappings = require('yanky.telescope.mapping')
  local yanky = require('yanky')

  yanky.setup({
    ring = {
      history_length = 100,
      storage = 'memory',
    },
    pickers = {
      telescope = {
        mappings = {
          default = mappings.put('p'),
          i = {
            ['<s-cr>'] = mappings.put('P'),
          },
        },
      },
    },
    system_clipboard = {
      sync_with_ring = false,
    },
  })

  local res, telescope = pcall(require, 'telescope')
  if res then
    telescope.load_extension('yank_history')
    keymap_set(
      { 'n', 'v' },
      { '<leader>p', '<leader>P' },
      telescope.extensions.yank_history.yank_history,
      { desc = '󱛢 Yanky: yank history' }
    )
  else
    print(vim.inspect(yanky))
    keymap_set({ 'n' }, 'p', function()
      yanky.put('p')
    end, { desc = '󰳺 Yanky: Insert after the cursor' })
    keymap_set({ 'n' }, 'P', function()
      yanky.put('P')
    end, { desc = '󰳸 Yanky: Insert before the cursor' })
    keymap_set({ 'n' }, '<leader>p', function()
      yanky.cycle(1)
    end, { desc = '󰅊 Yanky: Next item in the yank history' })
    keymap_set({ 'n' }, '<leader>P', function()
      yanky.cycle(-1)
    end, { desc = '󰱗 Yanky: Previous item in the yank history' })
  end
end

return {
  'gbprod/yanky.nvim',
  version = '^2',
  config = setupPlugin,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
}
