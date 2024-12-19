require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- Required
		"c",
		"lua",
		"markdown",
		"markdown_inline",
		"query",
		"vim",
		"vimdoc",

		-- Optional
		"bash",
		"go",
		"gomod",
		"hcl",
		"html",
		"json",
		"jsonnet",
		"ruby",
		"terraform",
		"yaml",

		-- "cue",
	},

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "gitcommit" },
		additional_vim_regex_highlighting = false,
	},
	endwise = { enable = true },
})

require("nvim-ts-autotag").setup()
