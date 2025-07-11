return {
  'Saghen/blink.cmp',
  version = '^1.4.1',
  opts = {
    completion = {
      keyword = { range = 'prefix' },
      trigger = { show_on_backspace = true },
      accept = {
        auto_brackets = {
          enabled = false,
          kind_resolution = { enabled = false },
          semantic_token_resolution = { enabled = false },
        },
      },
      menu = {
        border = 'solid',
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_icon' },
          },
          components = {
            source_icon = {
              width = { max = 2 },
              text = function(ctx)
                if ctx.source_id == 'lsp' then
                  if ctx.item.client_name == 'rust-analyzer' then
                    return ' '
                  end
                  -- FIXME: add more languages
                elseif ctx.source_id == 'buffer' then
                  return ' '
                elseif ctx.source_id == 'cmdline' then
                  return ' '
                elseif ctx.source_id == 'path' then
                  return ' '
                end

                return ' '
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 250 },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true, show_on_insert = true },
    fuzzy = {
      implementation = 'rust',
      use_frecency = false,
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      providers = {
        path = {
          min_keyword_length = 1,
        },
        buffer = {
          min_keyword_length = 4,
        },
      },
    },
    appearance = {
      kind_icons = {
        Class = '',
        Color = '󰏘',
        Constant = '󰏿',
        Constructor = '󱊍',
        Enum = '󰕘',
        EnumMember = ' ',
        Event = '',
        Field = ' ',
        File = '',
        Folder = '',
        Function = '󰊕',
        Interface = '',
        Keyword = '',
        Method = '󰡱',
        Module = '󱒌',
        Operator = '',
        Property = '',
        Reference = '',
        Snippet = '󱄽',
        Struct = '󰌗',
        Text = '',
        TypeParameter = '',
        Unit = '󰅲',
        Value = '󰦨',
        Variable = '󰫧',
      },
    },
  },
}
