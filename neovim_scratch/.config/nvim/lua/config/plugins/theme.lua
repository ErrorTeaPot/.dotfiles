vim.pack.add({
	'https://github.com/rose-pine/neovim',
})
require("rose-pine").setup { variant = "dawn", }
vim.cmd("colorscheme rose-pine")
