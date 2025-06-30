require("claude-code").setup()

require("copilot").setup({
	server = {
		type = "binary",
	},
	copilot_model = "gpt-4o-copilot",
})
