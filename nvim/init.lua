-- Lazy is the package manager
vim.g.mapleader = "\\" -- Leader must be specified before lazy
vim.g.maplocalleader = "\\"
require("config.lazy")

-- Setup icons
require("nvim-web-devicons").setup()

-- LSP configures the language server
require("config.lsp")

-- goto-preview shows definitions in a floating window
require("config.goto-preview")

-- telescope is a fuzzy finder
require("config.telescope")

-- oil is a file explorer
require("config.oil")

-- lualine is a statusline
require("config.lualine")

-- toggleterm is a terminal
require("config.toggleterm")

-- copilot is an AI assistant
require("config.copilot")

-- open definitons in a new tab
vim.keymap.set("n", "gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})

-- Disable mouse
vim.opt.mouse = ""

-- Keep cursor in the middle
vim.opt.scrolloff = 999

-- Errors
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)
