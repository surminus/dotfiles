require("goto-preview").setup({
	width = 120,
	height = 25,
	default_mappings = true,
})

vim.keymap.set("n", "<leader>d", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
