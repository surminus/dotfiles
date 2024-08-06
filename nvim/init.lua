-- Lazy is the package manager
vim.g.mapleader = "\\" -- Leader must be specified before lazy
vim.g.maplocalleader = "\\"
require("config.lazy")

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

-- open definitons in a new tab
vim.keymap.set("n", "gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})

-- Disable mouse
vim.opt.mouse = ""

-- Copilot
vim.keymap.set('i', '<leader>c', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
