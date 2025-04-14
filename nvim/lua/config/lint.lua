require("lint").linters_by_ft = {
	-- ruby = { "standardrb" },
	-- javascript = { "eslint_d" },
	-- typescript = { "eslint_d" },

	bash = { "shellcheck" },
	go = { "golangcilint" },
	markdown = { "vale" },
	sh = { "shellcheck" },
	-- terraform = { "tflint" },
}

require("mason-nvim-lint").setup({})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
