local function initPlugin()
	local rainbow_delimiters = require("rainbow-delimiters")

	require("rainbow-delimiters.setup").setup({
		strategy = {
			[""] = rainbow_delimiters.strategy["global"],
		},
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	})
end

return {
	"HiPhish/rainbow-delimiters.nvim",
	config = initPlugin,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
