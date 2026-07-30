-- Plugins
vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})
vim.cmd.packadd("fidget.nvim")
vim.cmd.packadd("nvim-lspconfig")
vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-tool-installer.nvim")

require("fidget").setup({})
require("mason").setup({})

-- Serveurs LSP
---@type table<string, vim.lsp.Config>
local servers = {
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=never",
		},
	},
	pyright = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				check = { command = "clippy" },
				checkOnSave = true,
			},
		},
	},
	marksman = {},
	nil_ls = {},
	terraformls = {},
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end
			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
			})
		end,
		settings = {
			Lua = { format = { enable = false } },
		},
	},
}

-- Noms des paquets Mason : ils ne correspondent pas toujours aux noms de serveur LSP
-- (ex. rust_analyzer -> rust-analyzer, lua_ls -> lua-language-server)
require("mason-tool-installer").setup({
	ensure_installed = {
		"clangd",
		"pyright",
		"rust-analyzer",
		"marksman",
		"nil",
		"terraform-ls",
		"lua-language-server",
		"stylua",
		"markdownlint-cli2",
		"tree-sitter-cli",
	},
})

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

-- Diagnostics
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		border = "rounded",
		source = true,
	},
})

-- Keymaps LSP
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, { desc = "[G]oto [D]eclaration" })
		)
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" })
		)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, { desc = "[G]oto [I]mplementation" })
		)
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "Signature Documentation" })
		)
		vim.keymap.set(
			"n",
			"<leader>cd",
			vim.lsp.buf.type_definition,
			vim.tbl_extend("force", opts, { desc = "[C]ode Type [D]efinition" })
		)
		vim.keymap.set(
			"n",
			"<leader>cr",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, { desc = "[C]ode [R]ename" })
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" })
		)
		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			vim.tbl_extend("force", opts, { desc = "[G]oto [R]eferences" })
		)
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, vim.tbl_extend("force", opts, { desc = "[C]ode [F]ormat" }))
	end,
})

-- Activer les LSPs
for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
