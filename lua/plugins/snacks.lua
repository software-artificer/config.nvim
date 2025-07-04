return {
  'folke/snacks.nvim',
  version = '^2.22',
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<C-o>'] = { '', mode = { 'i' } },
            ['<C-r>'] = { '', mode = { 'i' } },
          },
        },
      },
    },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
        only_current = true,
        char = {
          corner_top = '╭',
          corner_bottom = '╰',
        },
      },
    },
    gitbrowse = {
      enabled = true,
      what = 'permalink',
      open = function(url)
        vim.fn.setreg('+', url)
      end,
    },
  },
  priority = 1000,
  config = function(_, opts)
    local snacks = require('snacks')
    snacks.setup(opts)

    vim.lsp.buf.definition = function()
      snacks.picker.lsp_definitions({ auto_confirm = false, layout = 'bottom' })
    end

    vim.lsp.buf.declaration = function()
      snacks.picker.lsp_declarations({ auto_confirm = false, layout = 'bottom' })
    end

    vim.lsp.buf.references = function()
      snacks.picker.lsp_references({ auto_confirm = false, layout = 'bottom' })
    end

    vim.lsp.buf.implementation = function()
      snacks.picker.lsp_implementations({
        auto_confirm = false,
        layout = 'bottom',
      })
    end

    vim.lsp.buf.type_definition = function()
      snacks.picker.lsp_type_definitions({
        auto_confirm = false,
        layout = 'bottom',
      })
    end

    vim.lsp.buf.workspace_symbol = function()
      snacks.picker.lsp_workspace_symbols({
        auto_confirm = false,
        layout = 'bottom',
      })
    end

    vim.lsp.buf.document_symbol = function()
      snacks.picker.lsp_symbols({ auto_confirm = false, layout = 'bottom' })
    end
  end,
  keys = {
    {
      '<leader>ff',
      function()
        Snacks.picker.files({ cmd = 'fd', hidden = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Find [f]iles in the project',
    },
    {
      '<leader>fF',
      function()
        Snacks.picker.files({ cmd = 'fd', hidden = true, ignored = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Find [f]iles in the project including ignored',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers({ current = false })
      end,
      mode = { 'n', 'v' },
      desc = 'List open [b]uffers',
    },
    {
      '<leader>ft',
      function()
        Snacks.picker.grep({ cmd = 'rg', hidden = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Full [t]ext search',
    },
    {
      '<leader>fT',
      function()
        Snacks.picker.grep({ cmd = 'rg', hidden = true, ignored = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Full [t]ext search including ignored',
    },
    {
      '<leader>fw',
      function()
        Snacks.picker.grep_word()
      end,
      mode = { 'v' },
      desc = 'Find selection or [w]ord',
    },
    {
      '<leader>f"',
      function()
        Snacks.picker.registers()
      end,
      mode = { 'n', 'v' },
      desc = 'List register contents',
    },
    {
      '<leader>fd',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      mode = { 'n', 'v' },
      desc = 'Show buffer [d]iagnostics',
    },
    {
      '<leader>fD',
      function()
        Snacks.picker.diagnostics()
      end,
      mode = { 'n', 'v' },
      desc = 'Show project [d]iagnostics',
    },
    {
      '<leader><f1>',
      function()
        Snacks.picker.help()
      end,
      mode = { 'n', 'v' },
      desc = 'Search in NeoVim help files',
    },
    {
      '<leader>fh',
      function()
        Snacks.picker.highlights()
      end,
      mode = { 'n', 'v' },
      desc = 'List all defined [h]ighlight groups',
    },
    {
      '<leader>fi',
      function()
        Snacks.picker.icons()
      end,
      mode = { 'n', 'v' },
      desc = 'List all known [i]con glyphs',
    },
    {
      '<leader>fj',
      function()
        Snacks.picker.jumps()
      end,
      mode = { 'n', 'v' },
      desc = 'Open the [j]umplist',
    },
    {
      '<leader>fk',
      function()
        Snacks.picker.keymaps()
      end,
      mode = { 'n', 'v', 'x' },
      desc = 'List all [k]eymaps available in the current context',
    },
    {
      '<leader>fm',
      function()
        Snacks.picker.marks()
      end,
      mode = { 'n' },
      desc = 'List all current [m]arks',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.resume()
      end,
      mode = { 'n', 'v' },
      desc = '[R]esume previous picker',
    },
    {
      '<leader>fu',
      function()
        Snacks.picker.undo()
      end,
      mode = { 'n' },
      desc = 'Display [u]ndo history',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_files()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it [f]iles',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      mode = { 'n', 'v' },
      desc = 'Manage [g]it [b]ranches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it [l]og',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it log for the current [l]ine',
    },
    {
      '<leader>gh',
      function()
        Snacks.picker.git_log_file()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it [h]istory for the current file',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it [s]tatus',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      mode = { 'n', 'v' },
      desc = 'Show [g]it [d]iff',
    },
    {
      '<leader>gu',
      function()
        Snacks.gitbrowse()
      end,
      mode = { 'n', 'v' },
      desc = 'Copy [g]it [U]RL to the system clipboard',
    },
    --[[
    -- Maybe???
    todo_comments()
    trouble()
    --]]
  },
}
