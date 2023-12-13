return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    filters = {
      custom = { '.git' },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    view = {
      width = 40,
    },
    renderer = {
      special_files = {},
    },
    on_attach = function(bufnr)
      local nvim_tree_api = require('nvim-tree.api')

      local function set_keymap(key, action, opts)
        keymap_set('n', key, action, opts)
      end

      local function noop() end

      local function mkOption(icon, description)
        local desc = nil
        if description ~= nil then
          desc = icon .. ' NvimTree: ' .. description
        end

        return {
          desc = desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      set_keymap(
        { '<ESC>', 'q' },
        nvim_tree_api.tree.close_in_this_tab,
        mkOption('', 'Close Explorer')
      )
      set_keymap('<', function()
        nvim_tree_api.tree.collapse_all({ keep_buffers = true })
      end, mkOption('󰪦', 'Collapse all'))
      set_keymap(
        '>',
        nvim_tree_api.tree.expand_all,
        mkOption('󰪴', 'Expand all')
      )
      set_keymap(
        'n',
        nvim_tree_api.fs.create,
        mkOption('', '[N]ew file or directory')
      )
      set_keymap('d', nvim_tree_api.fs.remove, mkOption('󰧧', '[D]elete'))
      set_keymap(
        'r',
        nvim_tree_api.fs.rename_node,
        mkOption('󰑕', '[R]ename')
      )
      set_keymap('x', nvim_tree_api.fs.cut, mkOption('󰆐', 'Cut'))
      set_keymap('p', nvim_tree_api.fs.paste, mkOption('', '[P]aste'))
      set_keymap('c', nvim_tree_api.fs.copy.node, mkOption('', '[C]opy'))
      set_keymap(
        'ya',
        nvim_tree_api.fs.copy.absolute_path,
        mkOption('󰆏', '[Y]ank [a]bsolute path')
      )
      set_keymap(
        'yr',
        nvim_tree_api.fs.copy.relative_path,
        mkOption('󰆏', '[Y]ank [r]elative path')
      )
      set_keymap(
        'yy',
        nvim_tree_api.fs.copy.filename,
        mkOption('󰆏', '[Y]ank filename')
      )
      set_keymap(
        'gg',
        nvim_tree_api.node.navigate.parent,
        mkOption('', '[G]o to parent')
      )
      set_keymap(
        'gk',
        nvim_tree_api.node.navigate.sibling.prev,
        mkOption('󰒮', 'Previous sibling')
      )
      set_keymap(
        'gj',
        nvim_tree_api.node.navigate.sibling.next,
        mkOption('󰒭', 'Next sibling')
      )
      set_keymap('<CR>', nvim_tree_api.node.open.edit, mkOption('', 'Open'))

      set_keymap('K', noop, mkOption())
      set_keymap('v', noop, mkOption())
      set_keymap('V', noop, mkOption())
    end,
    actions = {
      open_file = {
        quit_on_open = true,
      },
      change_dir = {
        restrict_above_cwd = true,
      },
    },
    sync_root_with_cwd = true,
  },
  keys = {
    {
      '<leader>e',
      function()
        require('nvim-tree.api').tree.toggle({ find_file = true })
      end,
      mode = { 'n', 'v' },
      desc = ' NvimTree: Toggle file [e]xplorer',
    },
  },
}
