-- Configure language servers
local servers = {
	"gopls",
	"jsonls",
	"lua_ls",
	"solargraph",
	"taplo",
	"terraformls",
	"tflint",
	"ts_ls",
	"yamlls",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "cmp-yank" },
		{ name = "copilot" },
		{ name = "git" },
		{ name = "luasnip" },
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local on_attach = function(client)
	local bufopts = { noremap = true, silent = true }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Hover definition
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Open definition in buffer
	vim.keymap.set("n", "gt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", bufopts) -- Open definition in tab

	client.server_capabilities.documentFormattingProvider = true
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						"vim",
					},
				},
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
