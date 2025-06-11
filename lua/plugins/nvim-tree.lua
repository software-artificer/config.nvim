-- Function used to truncate the title of the floating window to its width
-- minus 7 characters to make it look nice with the borders.
local function string_left_truncate(str, max_chars)
  max_chars = max_chars - 7

  local str_chars = vim.fn.strchars(str)
  if str_chars <= max_chars then
    return str
  end

  local start_char = str_chars - max_chars
  return '…' .. vim.fn.strcharpart(str, start_char, max_chars)
end

return {
  'nvim-tree/nvim-tree.lua',
  version = '^1.12',
  -- which-key is not a dependency of nvim-tree, but we are using it here to
  -- add custom mapping with nice descriptions.
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/which-key.nvim' },
  -- Lazy-loading nvim-tree causes some issues, especially when it is replacing
  -- netrw, so disable it.
  lazy = false,
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    local nvim_tree_api = require('nvim-tree.api')

    -- Adjust the floating window size any time the NeoVim window is resized
    vim.api.nvim_create_autocmd('VimResized', {
      callback = function()
        if nvim_tree_api.tree.is_visible() then
          nvim_tree_api.tree.close()
          nvim_tree_api.tree.open()
        end
      end,
    })
  end,
  opts = {
    renderer = {
      -- Hide the root folder label (it is printed in the title instead)
      root_folder_label = false,
    },
    view = {
      float = {
        enable = true,
        open_win_config = function()
          -- Configure floating window to be centered with minimum size and
          -- position constraints.
          local screen_w = vim.o.columns
          local screen_h = vim.o.lines
          local size_w = math.max(math.floor(screen_w * 0.7), 35)
          local size_h = math.max(math.floor(screen_h * 0.7), 5)
          local pos_x = math.max(math.floor((screen_w - size_w) / 2), 0)
          local pos_y = math.max(math.floor((screen_h - size_h) / 2 - 1), 0)

          return {
            -- Use the current working directory as a floating window title.
            -- Truncate it on the left side if it is to long to the window size.
            title = string_left_truncate(vim.uv.cwd(), size_w),
            title_pos = 'center',
            border = 'rounded',
            relative = 'editor',
            row = pos_y,
            col = pos_x,
            width = size_w,
            height = size_h,
          }
        end,
      },
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local wk = require('which-key')

      -- Disable keympas that try to modify the buffer or switch modes and hide
      -- them in which-key legend.
      for _, keymap in
        next,
        { 'v', 'V', '<c-v>', 'i', 'I', 'o', 'O', 'r', 'R', '<c-r>', '.' }
      do
        wk.add({ keymap, function() end, hidden = true, buffer = bufnr })
      end

      for _, keymap in next, { 'q', 'Q', '<leader>q', '<leader>Q', '<Esc>' } do
        wk.add({
          keymap,
          api.tree.close,
          buffer = bufnr,
          desc = 'Close Nvim Tree',
          icon = { icon = '󱎘', color = 'yellow' },
        })
      end

      wk.add({
        '>',
        function()
          local node = api.tree.get_node_under_cursor()
          if node.type == 'directory' then
            api.tree.expand_all(node)
          end
        end,
        buffer = bufnr,
        desc = 'Expand all nodes under the cursor',
        icon = { icon = '󰅂', color = 'yellow' },
      })

      wk.add({
        '<',
        function()
          api.tree.collapse_all(true)
        end,
        buffer = bufnr,
        desc = 'Collapse all nodes',
        icon = { '󰄽', color = 'yellow' },
      })

      wk.add({
        '<CR>',
        function()
          api.node.open.edit(
            api.tree.get_node_under_cursor(),
            { quit_on_open = true }
          )
        end,
        buffer = bufnr,
        desc = 'Open the item under the cursor',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '/',
        api.live_filter.start,
        buffer = bufnr,
      })
    end,
    hijack_cursor = true,
    disable_netrw = true,
  },
  keys = {
    {
      mode = { 'n', 'v' },
      '<leader>e',
      function()
        require('nvim-tree.api').tree.toggle({ find_file = true })
      end,
      desc = 'Toggle file explorer (NvimTree)',
    },
  },
}
