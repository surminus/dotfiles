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
vim.g.go_highlight_fields = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_types = 1

-- Browse
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "xdg-open", opts.fargs[1] })
end, { nargs = 1 })

-- Set default log level
vim.lsp.set_log_level("error")

-- Sync buffers automatically
vim.opt.autoread = true

-- Disable swapfiles
vim.opt.swapfile = false

-- Switch between buffers
vim.keymap.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })

-- Close buffer
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { noremap = true, silent = true })

-- Move between windows
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

-- Split sensibly
vim.opt.splitbelow = true
vim.opt.splitright = true
