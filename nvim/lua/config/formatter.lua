local filetypes = require("formatter.filetypes")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		-- Note: use vim-go for Go
		-- go = { filetypes.go.gofmt, filetypes.go.goimports }

		html = { filetypes.html.htmlbeautifier },
		javascript = { filetypes.typescript.prettier, filetypes.typescript.eslint_d },
		json = { filetypes.json.jq },
		lua = { filetypes.lua.stylua },
		sh = { filetypes.sh.shfmt },
		toml = { filetypes.toml.taplo },
		typescript = { filetypes.typescript.prettier, filetypes.typescript.eslint_d },

		["*"] = { filetypes.any.remove_trailing_whitespace },
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"eslint_d",
		"htmlbeautifier",
		"jq",
		"prettier",
		"shfmt",
		"stylua",
		"taplo",
	},
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("__formatter__", { clear = true })

autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
