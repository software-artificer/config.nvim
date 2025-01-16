local cmp_kind_icons = {
  None = '',
  Method = '󰰐',
  Function = '󰊕',
  Constructor = '󱥉',
  Field = '',
  Variable = '󱄑',
  Class = '',
  Interface = '',
  Module = '󰕳',
  Property = '',
  Unit = '󱃗',
  Value = '󰿬',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '󰉦',
  File = '󰈔',
  Reference = '',
  Folder = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
  Text = '',
}

local cmp_source_names = {}

local function snippet_jump(fallback, direction)
  if vim.snippet.active({ direction = direction }) then
    vim.snippet.jump(direction)
  else
    fallback()
  end
end

local function jump_forward(fallback)
  snippet_jump(fallback, 1)
end

local function jump_backward(fallback)
  snippet_jump(fallback, -1)
end

local function getPluginOpts()
  local cmp = require('cmp')

  return {
    preselect = cmp.PreselectMode.Item,
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        vim_item.menu = cmp_source_names[entry.source.name] or entry.source.name
        vim_item.kind = cmp_kind_icons[vim_item.kind] or cmp_kind_icons.None

        return vim_item
      end,
    },
    mapping = {
      ['<C-Space>'] = { i = cmp.mapping.complete() },
      ['<C-d>'] = { i = cmp.mapping.scroll_docs(4) },
      ['<C-u>'] = { i = cmp.mapping.scroll_docs(-4) },
      ['<C-n>'] = { i = cmp.mapping.select_next_item() },
      ['<C-p>'] = { i = cmp.mapping.select_prev_item() },
      ['<C-e>'] = { i = cmp.mapping.abort() },
      ['<C-y>'] = { i = cmp.mapping.confirm({ select = true }) },
      ['<C-f>'] = cmp.mapping(jump_forward, { 'i', 's' }),
      ['<C-b>'] = cmp.mapping(jump_backward, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
    },
  }
end

return {
  {
    'hrsh7th/nvim-cmp',
    opts = getPluginOpts,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  {
    'hrsh7th/cmp-buffer',
  },
  {
    'hrsh7th/cmp-path',
  },
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'hrsh7th/cmp-nvim-lua',
  },
}
