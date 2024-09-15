require("lualine").setup({
	options = {
		theme = "moonfly",
	},
	sections = {
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = { "tabs" },
		lualine_z = { "buffers" },
	},
})
