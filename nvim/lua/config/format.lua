require("conform").setup({
	formatters_by_ft = {
		-- jsonnet = { "trim_whitespace" },
		-- yaml = { "trim_whitespace" }, -- Do not format YAML, but trim_whitespace

		["*"] = { "trim_whitespace" },
		css = { "prettierd" },
		html = { "htmlbeautifier" },
		javascript = { "prettier" },
		json = { "jq" },
		lua = { "stylua" },
		scss = { "prettier" },
		toml = { "taplo" },
		typescript = { "prettier" },
	},

	formatters = {
		prettier = {
			require_cwd = true,

			cwd = require("conform.util").root_file({
				".prettierrc",
				".prettierrc.json",
			}),
		},
	},

	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
		lsp_fallback = true,
		notify_no_formatters = true,
	},
})
