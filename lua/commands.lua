vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "help", "qf", "netrw" },
	desc = "keymap q to close various windows type",
	callback = function()
		vim.keymap.set("n", "q", "<C-w>c", { buffer = true, desc = "Quit window" })
	end,
})
