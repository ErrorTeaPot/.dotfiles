-- Plugins
vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})
vim.cmd.packadd("fidget.nvim")
vim.cmd.packadd("nvim-lspconfig")
vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-lspconfig.nvim")
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

-- stylua est un formatter, pas un LSP — on l'installe via mason séparément
local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { "stylua", "markdownlint-cli2" })
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- Inlay hints (correctement)
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

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
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- Activer les LSPs
for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
