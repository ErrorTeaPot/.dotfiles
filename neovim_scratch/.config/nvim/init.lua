require("config.remap")
require("config.lsp")
require("config.tabs")

-- OPTIONS
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.o.clipboard = "unnamedplus"
	end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- AUTOCOMMANDS (EVENT HANDLERS)
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore cursor shape (solution simple et directe)
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.opt.guicursor = ""
	end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".") -- Get the current line number. See `:h line()`
	local filename = vim.api.nvim_buf_get_name(0)
	print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line" })

-- PLUGINS
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd("packadd! nohlsearch")

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
	-- Quickstart configs for LSP
	"https://github.com/neovim/nvim-lspconfig",
})

-- Import plugins from lua/config/plugins
require("config.plugins")
