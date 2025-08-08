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
    filters = {
      custom = {
        -- hide .git directory from the tree
        '^\\.git$',
      },
    },
    -- display "modified buffer" icon
    modified = { enable = true },
    diagnostics = {
      enable = true,
      icons = {
        error = ' ',
        warning = ' ',
        info = ' ',
        hint = ' ',
      },
    },
    renderer = {
      -- Hide the root folder label (it is printed in the title instead)
      root_folder_label = false,
      icons = {
        git_placement = 'after',
        modified_placement = 'after',
        glyphs = {
          folder = {
            default = '',
            open = '',
          },
          git = {
            deleted = '',
            staged = '󰸩',
            unstaged = '',
            untracked = '󰈤',
            renamed = '',
            ignored = '󰘓',
            unmerged = '󱀫',
          },
        },
      },
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
        { 'v', 'V', '<c-v>', 'I', 'o', 'O', 'R', 'C', 'D', 'a', 'A' }
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
        icon = { icon = '󰄾', color = 'yellow' },
      })

      wk.add({
        '<',
        function()
          api.tree.collapse_all({ keep_buffers = false })
        end,
        buffer = bufnr,
        desc = 'Collapse all nodes',
        icon = { '󰄽', color = 'yellow' },
      })

      wk.add({
        '<CR>',
        function()
          api.node.open.edit(nil, { quit_on_open = true })
        end,
        buffer = bufnr,
        desc = 'Open the item under the cursor',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '<c-r>',
        api.tree.reload,
        buffer = bufnr,
        desc = 'Refresh the file tree',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '.',
        api.tree.toggle_enable_filters,
        buffer = bufnr,
        desc = 'Toggle hidden nodes',
        icon = { icon = '󰘓', color = 'yellow' },
      })

      wk.add({
        '?',
        api.node.show_info_popup,
        buffer = bufnr,
        desc = 'Show node properties',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'i',
        api.fs.create,
        buffer = bufnr,
        desc = 'Create a new file or directory',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'I',
        function()
          local node = api.tree.get_node_under_cursor()
          if node == nil then
            return
          end

          if node.type == 'directory' then
            api.fs.create(node.parent)

            return
          end

          api.fs.create()
        end,
        buffer = bufnr,
        desc = 'Create a new sibling file or directory',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'd',
        api.fs.remove,
        buffer = bufnr,
        desc = 'Delete a file or directory',
        icon = { icon = '󰗨', color = 'yellow' },
      })

      wk.add({
        'r',
        api.fs.rename_node,
        buffer = bufnr,
        desc = 'Rename a file or directory',
        icon = { icon = '󰑕', color = 'yellow' },
      })

      wk.add({
        'x',
        api.fs.cut,
        buffer = bufnr,
        desc = 'Cut a file or directory',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'p',
        api.fs.paste,
        buffer = bufnr,
        desc = 'Paste copied or cut files and directories',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'c',
        api.fs.copy.node,
        buffer = bufnr,
        desc = 'Copy a file or directory',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'yy',
        api.fs.copy.absolute_path,
        buffer = bufnr,
        desc = 'Copy an absolute path to the node',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'ya',
        api.fs.copy.relative_path,
        buffer = bufnr,
        desc = 'Copy a relative path to the node',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        'Y',
        api.fs.copy.filename,
        buffer = bufnr,
        desc = 'Copy a name of a file or directory',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        ']g',
        api.node.navigate.git.next_recursive,
        buffer = bufnr,
        desc = 'Go to the next node with a Git status',
        icon = { icon = '󰊢', color = 'yellow' },
      })

      wk.add({
        '[g',
        api.node.navigate.git.prev_recursive,
        buffer = bufnr,
        desc = 'Go to the previous node with a Git status',
        icon = { icon = '󰊢', color = 'yellow' },
      })

      wk.add({
        ']d',
        api.node.navigate.diagnostics.next_recursive,
        buffer = bufnr,
        desc = 'Go to the next node with a diagnostics status',
        icon = { icon = '', color = 'yellow' },
      })

      wk.add({
        '[d',
        api.node.navigate.diagnostics.prev_recursive,
        buffer = bufnr,
        desc = 'Go to the previous node with a diagnostics status',
        icon = { icon = '', color = 'yellow' },
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
        require('nvim-tree.api').tree.toggle({
          path = vim.uv.cwd(),
          find_file = true,
        })
      end,
      desc = 'Toggle file explorer (NvimTree)',
    },
  },
}
