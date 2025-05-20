local servers = {
	"cssls",
	"dagger",
	"eslint",
	"golangci_lint_ls",
	"gopls",
	"html",
	"jsonls",
	"jsonnet_ls",
	"lua_ls",
	"pyright",
	"solargraph",
	"taplo",
	"terraformls",
	"ts_ls",
	"yamlls",
}

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })

local on_attach = function(client)
	local bufopts = { noremap = true, silent = true }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Hover definition
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Open definition in buffer

	client.server_capabilities.documentFormattingProvider = true
end

vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
	root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable(servers)
