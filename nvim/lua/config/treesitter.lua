local languages = {
	"bash",
	"go",
	"gomod",
	"hcl",
	"html",
	"json",
	"jsonnet",
	"lua",
	"markdown",
	"markdown_inline",
	"query",
	"ruby",
	"terraform",
	"vim",
	"vimdoc",
	"yaml",
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
