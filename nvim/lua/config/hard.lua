vim.keymap.set("n", "<PageUp>", "<Nop>")
vim.keymap.set("n", "<PageUp>", "<Nop>")

for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	vim.keymap.set("n", key, "<Nop>")
	vim.keymap.set("i", key, "<Nop>")
	vim.keymap.set("c", key, "<Nop>")
end
