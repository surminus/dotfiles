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

	-- Snacks
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			gh = { enabled = true },
			indent = { enabled = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
			},
			{
				"<leader>f",
				function()
					Snacks.picker.files()
				end,
			},
			{
				"<leader>f",
				function()
					Snacks.picker.files()
				end,
			},
			{
				"<leader>w",
				function()
					Snacks.picker.grep_word()
				end,
				mode = { "n", "x" },
			},
			{
				"<leader>s",
				function()
					Snacks.picker.grep()
				end,
			},
		},
	},

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

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{ "AndreM222/copilot-lualine" },

	-- Syntax
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
	},

	"fladson/vim-kitty",
	"hashivim/vim-terraform",

	-- Go
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		ft = { "go", "gomod" },
	},

	-- Other tools
	"AndrewRadev/switch.vim",
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
