require("conform").setup({
	formatters_by_ft = {
		css = { "prettierd" },
		html = { "htmlbeautifier" },
		javascript = { "prettierd", "eslint_d" },
		json = { "jq" },
		-- jsonnet = { "jsonnetfmt" },
		jsonnet = { "trim_whitespace" },
		lua = { "stylua" },
		python = { "flake8" },
		scss = { "prettierd" },
		toml = { "taplo" },
		typescript = { "prettierd", "eslint_d" },
		yaml = { "trim_whitespace" }, -- Do not format YAML, but trim_whitespace
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"eslint_d",
		"flake8",
		"htmlbeautifier",
		"jq",
		"jsonnetfmt",
		"prettierd",
		"shfmt",
		"stylua",
		"taplo",
	},
})
