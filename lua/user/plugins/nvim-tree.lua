local function configure_nvim_tree()
	local nvim_tree = require("nvim-tree")
	local nvim_tree_api = require("nvim-tree.api")
	local function set_keymap(key, action, opts)
		vim.keymap.set("n", key, action, opts)
	end

	nvim_tree.setup({
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
			local function mkOption(description)
				return {
					desc = "nvim-tree: " .. description,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end

			set_keymap("<ESC>", nvim_tree_api.tree.close_in_this_tab, mkOption("Close Explorer"))
			set_keymap(",", function()
				nvim_tree_api.tree.collapse_all({ keep_buffers = true })
			end, mkOption("Collapse all"))
			set_keymap(".", nvim_tree_api.tree.expand_all, mkOption("Expand all"))
			set_keymap("n", nvim_tree_api.fs.create, mkOption("[N]ew file or directory"))
			set_keymap("d", nvim_tree_api.fs.remove, mkOption("[D]elete"))
			set_keymap("r", nvim_tree_api.fs.rename_node, mkOption("[R]ename"))
			set_keymap("x", nvim_tree_api.fs.cut, mkOption("Cut"))
			set_keymap("p", nvim_tree_api.fs.paste, mkOption("[P]aste"))
			set_keymap("c", nvim_tree_api.fs.copy.node, mkOption("[C]opy"))
			set_keymap("ya", nvim_tree_api.fs.copy.absolute_path, mkOption("Copy absolute path"))
			set_keymap("yr", nvim_tree_api.fs.copy.relative_path, mkOption("Copy relative path"))
			set_keymap("yy", nvim_tree_api.fs.copy.filename, mkOption("Copy filename"))
			set_keymap("gg", nvim_tree_api.node.navigate.parent, mkOption("Go to parent"))
			set_keymap("gk", nvim_tree_api.node.navigate.sibling.prev, mkOption("Previous sibling"))
			set_keymap("gj", nvim_tree_api.node.navigate.sibling.next, mkOption("Next sibling"))
			set_keymap("<CR>", nvim_tree_api.node.open.edit, mkOption("Open"))
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
	})

	-- Allow opening up the file tree browser anywhere
	set_keymap("<leader>e", function(a, b, c)
		nvim_tree_api.tree.toggle({ find_file = true })
	end, {
		desc = "nvim-tree: Toggle [E]xplorer",
		noremap = true,
		silent = true,
		nowait = true,
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = configure_nvim_tree,
}
