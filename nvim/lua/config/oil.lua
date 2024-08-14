require("oil").setup({
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil --float .<CR>",  { desc = "Open Oil explorer view" })
