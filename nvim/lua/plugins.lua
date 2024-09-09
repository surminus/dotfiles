return {
	{
		"bluz71/vim-moonfly-colors",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme moonfly]])
		end,
	},

	-- LSP
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",

	"chrisgrieser/cmp_yanky",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"petertriho/cmp-git",

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"saadparwaiz1/cmp_luasnip",

	-- Mason
	"williamboman/mason.nvim",

	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"rshkarin/mason-nvim-lint",
	"williamboman/mason-lspconfig.nvim",

	-- Formatting
	"mhartington/formatter.nvim",

	-- Linting
	"mfussenegger/nvim-lint",

	-- Definitions
	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = true, -- required
	},

	-- Git
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Search
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Filesystem
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},

	-- Copilot
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Syntax
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	"fatih/vim-go",
	"fladson/vim-kitty",
	"hashivim/vim-terraform",

	-- Tools
	"cohama/lexima.vim",
	"dstein64/vim-startuptime",
	"farmergreg/vim-lastplace",
	"godlygeek/tabular",
	"lewis6991/gitsigns.nvim",
	"myusuf3/numbers.vim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"tpope/vim-endwise",
	"tpope/vim-repeat",
	"tpope/vim-sensible",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",
}
