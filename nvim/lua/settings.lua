-- Disable mouse
vim.opt.mouse = ""

-- Keep cursor in the middle
vim.opt.scrolloff = 999

-- Errors
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)

-- Browse
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "xdg-open", opts.fargs[1] })
end, { nargs = 1 })

-- Disable LSP log (enable again with "debug")
vim.lsp.set_log_level("off")

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

-- Delete without yanking
vim.keymap.set("x", "D", '"_d', { desc = "Delete without yanking" })

-- Toggle numbers
vim.keymap.set("n", "<leader>n", ":NumbersToggle<CR>", { noremap = true, silent = true })

-- " Custom commands
vim.api.nvim_create_user_command("Blame", "Git blame", {})
vim.api.nvim_create_user_command("Reload", "source ~/.vimrc", {})
vim.api.nvim_create_user_command("Save", "Git save", {})
vim.api.nvim_create_user_command("Terminal", "term ++close ++rows=10", {})

-- Delete whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
	end,
})

-- Search within visual selection
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- Other options
vim.opt.autoindent = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.number = true
vim.opt.ruler = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
