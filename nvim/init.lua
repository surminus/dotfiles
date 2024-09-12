-- Lazy is the package manager
vim.g.mapleader = "\\" -- Leader must be specified before lazy
vim.g.maplocalleader = "\\"
require("config.lazy")

-- Setup icons
require("nvim-web-devicons").setup()

-- Core
require("config.lsp")
require("config.treesitter")
require("config.formatter")
require("config.lint")

-- More
require("config.custom")
require("config.gitsigns")
require("config.goto-preview")
require("config.lualine")
require("config.oil")
require("config.substitute")
require("config.telescope")
require("config.toggleterm")

-- copilot is an AI assistant
-- require("config.copilot")
