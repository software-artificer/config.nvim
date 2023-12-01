local function hop()
  return require('hop')
end

return {
  'smoka7/hop.nvim',
  version = '^2',
  opts = {
    keys = 'arstneioqwfpluy;zxcvm,./',
    quit_key = '<esc>',
  },
  keys = {
    {
      '<leader>jt',
      function()
        require('hop-treesitter').hint_nodes()
      end,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [t]ree-sitter node',
    },
    {
      '<leader>jw',
      function()
        hop().hint_words()
      end,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [w]ord',
    },
    {
      '<leader>jl',
      function()
        hop().hint_lines_skip_whitespace()
      end,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [l]ine',
    },
    {
      '<leader>jc',
      function()
        hop().hint_char1()
      end,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [c]haracter',
    },
  },
}
