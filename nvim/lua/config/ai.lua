require("claude-code").setup()

require("copilot").setup({
	suggestion = {
		auto_trigger = true,
	},
	server = {
		type = "binary",
	},
	copilot_model = "gpt-4o-copilot",
})

vim.keymap.set("n", "<leader>l", "<CMD>Copilot toggle<CR>", { desc = "Toggle Copilot" })
