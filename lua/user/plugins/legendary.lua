local function telescopeSelector(items, opts, on_choice)
  local themes = require('telescope.themes')
  local actions = require('telescope.actions')
  local state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  -- schedule_wrap because closing the windows is deferred
  -- See https://github.com/nvim-telescope/telescope.nvim/pull/2336
  -- And we only want to dispatch the callback when we're back in the original win
  on_choice = vim.schedule_wrap(on_choice)

  local entry_maker = function(item)
    local formatted = opts.format_item(item)

    return {
      display = formatted,
      ordinal = formatted,
      value = item,
    }
  end

  pickers
    .new(
      themes.get_dropdown({
        layout_config = {
          height = 0.90,
          width = 0.95,
          prompt_position = 'bottom',
        },
        attach_mappings = function(_, map)
          map('i', '<c-u>', actions.results_scrolling_up)
          map('i', '<c-d>', actions.results_scrolling_down)

          return true
        end,
      }),
      {
        prompt_title = opts.prompt,
        previewer = false,
        finder = finders.new_table({
          results = items,
          entry_maker = entry_maker,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = state.get_selected_entry()
            actions.close(prompt_bufnr)

            if not selection then
              return
            end

            local idx = nil
            for i, item in ipairs(items) do
              if item == selection.value then
                idx = i
                break
              end
            end

            on_choice(selection.value, idx)
          end)

          return true
        end,
      }
    )
    :find()
end

local function setupPlugin()
  local legendary = require('legendary')
  local filters = require('legendary.filters')
  local selector = vim.ui.select
  vim.ui.select = function(items, opts, on_choice)
    if opts.kind == 'legendary.nvim' then
      telescopeSelector(items, opts, on_choice)
    else
      selector(items, opts, on_choice)
    end
  end

  legendary.setup({
    extensions = { lazy_nvim = { auto_register = true }, nvim_tree = true },
    keymaps = {
      {
        '<leader>q',
        {
          n = function()
            vim.api.nvim_buf_delete(0, { force = true })
          end,
        },
        description = ' [Q]uit current buffer',
      },
      {
        '<leader>d',
        { n = vim.diagnostic.open_float },
        description = '󰮦 Show [d]iagnostic popup',
      },
      {
        ']d',
        { n = vim.diagnostic.goto_next },
        description = ' Go to next [d]iagnostic message',
      },
      {
        '[d',
        { n = vim.diagnostic.goto_prev },
        description = ' Go to previous [d]iagnostic message',
      },
      {
        '<leader>F',
        { n = vim.lsp.buf.format },
        description = '󰉼 [F]ormat document using LSP',
      },
      {
        '<leader>hk',
        {
          n = function()
            legendary.find({ filters = { filters.keymaps() } })
          end,
        },
        description = '󰌌 Show [h]elp for [k]eymaps',
      },
      {
        '<leader>hc',
        {
          n = function()
            legendary.find({ filters = { filters.commands() } })
          end,
        },
        description = ' Show [h]elp for [c]ommands',
      },
      {
        '<leader>hf',
        {
          n = function()
            legendary.find({ filters = { filters.funcs() } })
          end,
        },
        description = '󰡱 Show [h]elp for [f]unctions',
      },
      {
        '<leader>ha',
        {
          n = function()
            legendary.find({ filters = { filters.autocmds() } })
          end,
        },
        description = ' Show [h]elp for [a]utocommands',
      },
      {
        '<leader>H',
        function()
          legendary.find({
            filters = { filters.keymaps(), filters.current_mode() },
          })
        end,
        description = ' Show [h]elp for current mode',
      },
    },
  })
end

return {
  'mrjones2014/legendary.nvim',
  version = '^2',
  config = setupPlugin,
  lazy = false,
  -- Needed because it should handle _all_ keymaps
  priority = 10000,
  dependencies = {
    'telescope/telescope.nvim',
  },
}
