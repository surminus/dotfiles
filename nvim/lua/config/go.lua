-- https://github.com/ray-x/go.nvim
require("go").setup({
	lsp_cfg = false,
	-- settings = {
	-- 	gopls = {
	-- 		buildFlags = { "-tags=integration" },
	-- 	},
	-- },
	-- },
	lsp_inlay_hints = {
		enable = false,
	},
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = format_sync_grp,
})
