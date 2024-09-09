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
require("config.goto-preview")
require("config.lualine")
require("config.oil")
require("config.telescope")
require("config.toggleterm")

-- copilot is an AI assistant
-- require("config.copilot")

-- Setup gitsigns
require('config.gitsigns')

-- open definitons in a new tab
vim.keymap.set("n", "gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})

-- Disable mouse
vim.opt.mouse = ""

-- Keep cursor in the middle
vim.opt.scrolloff = 999

-- Errors
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)

-- vim-go
vim.g.go_code_completion_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_diagnostics_level = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_gopls_enabled = 0
vim.g.go_highlight_fields = 0
vim.g.go_highlight_function_calls = 0
vim.g.go_highlight_operators = 0
vim.g.go_highlight_types = 0
