local filetypes = require("formatter.filetypes")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		-- Note: use vim-go for Go
		-- go = { filetypes.go.gofmt, filetypes.go.goimports }

		lua = { filetypes.lua.stylua },
		sh = { filetypes.sh.shfmt },
		json = { filetypes.json.jq },
		typescript = { filetypes.typescript.prettier },

		["*"] = { filetypes.any.remove_trailing_whitespace },
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"jq",
		"prettier",
		"shfmt",
		"stylua",
	},
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("__formatter__", { clear = true })

autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
