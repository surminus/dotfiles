require("oil").setup({
	skip_confirm_for_simple_edits = true,
	view_options = { show_hidden = true },
	watch_for_changes = true,

	float = {
		padding = 10,
		max_width = 0,
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		preview_split = "right",
	},
})

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
