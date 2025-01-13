local function hop()
  return require('hop')
end

local function hint_direction()
  return require('hop.hint').HintDirection
end

local function after_cursor()
  return hint_direction().AFTER_CURSOR
end

local function before_cursor()
  return hint_direction().BEFORE_CURSOR
end

local function hop_treesitter()
  require('hop-treesitter').hint_nodes()
end

local function hop_words_before_cursor()
  hop().hint_words({ direction = before_cursor() })
end

local function hop_words_after_cursor()
  hop().hint_words({ direction = after_cursor() })
end

local function hop_words_before_cursor_on_the_same_line()
  hop().hint_words({ direction = before_cursor(), current_line_only = true })
end

local function hop_words_after_cursor_on_the_same_line()
  hop().hint_words({ direction = after_cursor(), current_line_only = true })
end

local function hop_lines_before_cursor()
  hop().hint_lines_skip_whitespace({ direction = before_cursor() })
end

local function hop_lines_after_cursor()
  hop().hint_lines_skip_whitespace({ direction = after_cursor() })
end

local function hop_characters_after_cursor()
  hop().hint_char1({ direction = after_cursor() })
end

local function hop_characters_before_cursor()
  hop().hint_char1({ direction = before_cursor() })
end

return {
  'smoka7/hop.nvim',
  version = '^2.7',
  opts = {
    keys = 'arstneioqwfpluy;zxcvm,./',
    quit_key = '<esc>',
  },
  keys = {
    {
      '<leader>jt',
      hop_treesitter,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [t]ree-sitter nodes',
    },
    {
      '<leader>jw',
      hop_words_after_cursor_on_the_same_line,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [w]ords on the same line after the cursor',
    },
    {
      '<leader>jW',
      hop_words_after_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [w]ords after the cursor',
    },
    {
      '<leader>jb',
      hop_words_before_cursor_on_the_same_line,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to words on the same line [b]efore the cursor',
    },
    {
      '<leader>jB',
      hop_words_before_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to words [b]efore the cursor',
    },
    {
      '<leader>jj',
      hop_lines_after_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [l]ines after the cursor',
    },
    {
      '<leader>jk',
      hop_lines_before_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [l]ines before the cursor',
    },
    {
      '<leader>jf',
      hop_characters_after_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [c]haracters after the cursor',
    },
    {
      '<leader>jF',
      hop_characters_before_cursor,
      mode = { 'n', 'v' },
      desc = '󰤇 Hop: [J]ump to [c]haracters before the cursor',
    },
  },
}
