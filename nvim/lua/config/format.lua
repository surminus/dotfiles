require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "htmlbeautifier" },
		javascript = { "prettierd", "eslint_d" },
		json = { "jq" },
		scss = { "prettierd" },
		sh = { "shfmt" },
		toml = { "taplo" },
		typescript = { "prettierd", "eslint_d" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"eslint_d",
		"htmlbeautifier",
		"jq",
		"prettierd",
		"shfmt",
		"stylua",
		"taplo",
	},
})
