vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

local languages = { "rust", "python", "markdown", "nix", "lua" }

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function(ev)
		vim.treesitter.start(ev.buf)
	end,
})
