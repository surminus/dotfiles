-- Configure language servers
local servers = {
  "gopls",
  "lua_ls",
  "solargraph",
  "terraformls",
  "tflint",
  "tsserver",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),

  sources = {
    { name = "copilot" },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local on_attach = function()
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true })
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
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
  }
end
