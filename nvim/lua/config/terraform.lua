vim.cmd([[let g:terraform_align=1]])
vim.cmd([[let g:terraform_binary_path="tofu"]])
vim.cmd([[let g:terraform_fmt_on_save=1]])

local function terraform_func()
	local word = vim.fn.expand("<cword>")

	local url = "https://developer.hashicorp.com/terraform/language/functions/"

	if not word == "" then
		url = url .. word .. ".html"
	end

	os.execute("xdg-open " .. url)
end
vim.api.nvim_create_user_command("TerraformFunc", terraform_func, {})

-- Hashicorp maintains a special set of providers that use a different URL
-- in documentation
local hashicorp_providers = {
	"ad",
	"archive",
	"assert",
	"aws",
	"awscc",
	"azuread",
	"azurerm",
	"azurestack",
	"boundary",
	"cloudinit",
	"consul",
	"dns",
	"external",
	"google",
	"google-beta",
	"googleworkspace",
	"hashicorp",
	"hcp",
	"hcs",
	"helm",
	"http",
	"kubernetes",
	"local",
	"nomad",
	"null",
	"opc",
	"oraclepaas",
	"random",
	"salesforce",
	"template",
	"tfe",
	"tfmigrate",
	"time",
	"tls",
	"vault",
	"vsphere",
}

local function terraform_docs()
	local line = vim.api.nvim_get_current_line()
	local type, name = string.match(line, '^(%w+) "([%w_]+)" .*$')

	if type == "" or name == "" then
		return
	end

	local provider, identifier = string.match(name, "^(%w+)_([%w+)$")
	local namespace = provider

	for _, value in ipairs(hashicorp_providers) do
		if value == namespace then
			namespace = "hashicorp"
			break
		end
	end

	local root = "https://registry.terraform.io/providers/" .. namespace .. "/" .. provider .. "/latest/docs/"

	local typeurl = "resources"
	if type == "data" then
		typeurl = "data-sources"
	end

	local url = root .. "/" .. typeurl .. "/" .. identifier

	os.execute("xdg-open " .. url)
end
vim.api.nvim_create_user_command("TerraformDocs", terraform_docs, {})
