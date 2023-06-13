local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
	vim.notify("Neotree not found")
	return
end
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neo_tree.setup({
	close_if_last_window = true,
	enable_diagnostics = false,
	-- source_selector = {
	-- 	winbar = true,
	-- 	content_layout = "center",
	-- 	-- tab_labels = {
	-- 	-- 	filesystem = " File",
	-- 	-- 	buffers = "➜ Buffs",
	-- 	-- 	git_status = " Git",
	-- 	-- 	diagnostics = "",
	-- 	-- },
	-- },
	default_component_configs = {
		-- indent = {
		-- 	padding = 0,
		-- },
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
		-- git_status = {
		-- 	symbols = {
		-- 		unstaged = "✗",
		-- 		staged = "✓",
		-- 		unmerged = "",
		-- 		renamed = "➜",
		-- 		untracked = "★",
		-- 		deleted = "",
		-- 		ignored = "◌",
		-- 	},
		-- },
	},
	window = {
		width = 30,
		mappings = {
			["n"] = "open",
			["c"] = "close_node",
			["m"] = "copy",
			["t"] = "",
			["T"] = "open_tabnew",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = false,
			hide_dotfiles = true,
			hide_gitignored = true,
		},
	},
	event_handlers = {
		-- {
		-- 	event = "neo_tree_buffer_enter",
		-- 	handler = function(_)
		-- 		vim.opt_local.signcolumn = "auto"
		-- 	end,
		-- },
	},
})
