-- Lazy is the package manager
vim.g.mapleader = "\\" -- Leader must be specified before lazy
vim.g.maplocalleader = "\\"
require("config.lazy")

-- Setup colorscheme
vim.opt.termguicolors = true
vim.cmd([[colorscheme moonfly]])

-- Default settings
require("settings")

-- Setup icons
require("nvim-web-devicons").setup()

-- Core
require("config.cmp")
require("config.format")
require("config.lint")
require("config.lsp")
require("config.treesitter")

-- More
require("config.gitsigns")
require("config.go")
require("config.goto-preview")
require("config.hard")
require("config.lualine")
require("config.oil")
require("config.spider")
require("config.substitute")
require("config.tabular")
require("config.telescope")
require("config.terraform")
require("config.toggleterm")

-- AI
require("config.ai")
