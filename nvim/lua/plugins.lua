return {
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
	},

	-- LSP
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"linrongbin16/lsp-progress.nvim",

	-- Completions
	"hrsh7th/cmp-nvim-lsp",
	"chrisgrieser/cmp_yanky",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"onsails/lspkind.nvim",
	"petertriho/cmp-git",

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"saadparwaiz1/cmp_luasnip",

	-- Theme
	"bluz71/vim-moonfly-colors",

	-- Formatting
	"rshkarin/mason-nvim-lint",
	"stevearc/conform.nvim",

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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Filesystem
	{
		"stevearc/oil.nvim",
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

	-- AI
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{ "AndreM222/copilot-lualine" },

	-- Syntax
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"windwp/nvim-ts-autotag",

	"fladson/vim-kitty",
	"hashivim/vim-terraform",

	-- Go
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		ft = { "go", "gomod" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
	},

	-- Practice
	-- Use :Hardtime to toggle
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			enabled = false,
		},
	},

	-- Other tools
	"AndrewRadev/switch.vim",
	"MagicDuck/grug-far.nvim",
	"RRethy/nvim-treesitter-endwise",
	"chrisgrieser/nvim-spider",
	"farmergreg/vim-lastplace",
	"gbprod/substitute.nvim",
	"godlygeek/tabular",
	"lewis6991/gitsigns.nvim",
	"myusuf3/numbers.vim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"tpope/vim-sleuth",
	"tpope/vim-surround",

	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
