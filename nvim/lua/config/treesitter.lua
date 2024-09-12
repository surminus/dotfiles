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
		"cue",
		"go",
		"gomod",
		"hcl",
		"json",
		"jsonnet",
		"ruby",
		"terraform",
		"yaml",
	},

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "gitcommit" },
		additional_vim_regex_highlighting = true,
	},
})
