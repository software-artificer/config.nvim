local cmp_kind_icons = {
	None = "",
	Method = "󰰐",
	Function = "󰊕",
	Constructor = "󱥉",
	Field = "",
	Variable = "󱄑",
	Class = "",
	Interface = "",
	Module = "󰕳",
	Property = "",
	Unit = "󱃗",
	Value = "󰿬",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "󰉦",
	File = "󰈔",
	Reference = "",
	Folder = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
	Text = "",
}

local cmp_source_names = {}

local function setupCmp()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local function luasnip_jump(direction, fallback)
		if luasnip.jumpable(direction) then
			luasnip.jump(direction)
		else
			fallback()
		end
	end

	local function luasnip_jump_next(fallback)
		luasnip_jump(1, fallback)
	end

	local function luasnip_jump_prev(fallback)
		luasnip_jump(-1, fallback)
	end

	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			-- configure window appearance for documentation and completion
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.menu = cmp_source_names[entry.source.name] or entry.source.name
				vim_item.kind = cmp_kind_icons[vim_item.kind] or cmp_kind_icons.None

				return vim_item
			end,
		},
		mapping = {
			["<C-Space>"] = { i = cmp.mapping.complete() },
			["<C-d>"] = { i = cmp.mapping.scroll_docs(-4) },
			["<C-u>"] = { i = cmp.mapping.scroll_docs(4) },
			["<C-n>"] = { i = cmp.mapping.select_next_item() },
			["<C-p>"] = { i = cmp.mapping.select_prev_item() },
			["<C-e>"] = { i = cmp.mapping.abort() },
			["<C-f>"] = cmp.mapping(luasnip_jump_next, { "i" }),
			["<C-b>"] = cmp.mapping(luasnip_jump_prev, { "i" }),
			["<C-y>"] = { i = cmp.mapping.confirm({ select = true }) },
		},
		sources = {
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer", keyword_length = 5 },
		},
	})
end

return {
	{
		"hrsh7th/nvim-cmp",
		config = setupCmp,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		tag = "v2.0.0",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-nvim-lua",
	},
}
