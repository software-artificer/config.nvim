local lsp_icons = {
  ['rust-analyzer'] = ' ',
  ['gopls'] = ' ',
}

return {
  'Saghen/blink.cmp',
  version = '^1.10',
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
        auto_show_delay_ms = 200,
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
                if ctx.source_id == 'buffer' then
                  return ' '
                elseif ctx.source_id == 'cmdline' then
                  return ' '
                elseif ctx.source_id == 'path' then
                  return ' '
                end

                if ctx.source_id == 'lsp' then
                  return lsp_icons[ctx.item.client_name] or ' '
                end

                return ' '
              end,
            },
          },
          snippet_indicator = '',
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 250 },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true, trigger = { show_on_insert = true } },
    fuzzy = {
      implementation = 'rust',
      frecency = {
        enabled = false,
      },
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
