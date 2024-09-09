require("lint").linters_by_ft = {
	bash = { "shellcheck" },
	go = { "golangcilint" },
	markdown = { "vale" },
	ruby = { "standardrb" },
	sh = { "shellcheck" },
	terraform = { "tflint" },
}

require("mason-nvim-lint").setup({})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
