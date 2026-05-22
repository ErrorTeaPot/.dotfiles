vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  See `:help lsp-config` for information about keys and how to configure
---@type table<string, vim.lsp.Config>
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=never",
		},
		settings = {
			["clangd"] = {
				-- Activer l'auto-complétion détaillée
				completion = {
					detailedLabel = true,
				},
				-- Activer les diagnostics avancés
				diagnostics = {
					clangTidy = {
						add = {
							"modernize-*",
							"performance-*",
							"bugprone-*",
							"readability-*",
							"portability-*",
							"clang-analyzer-*",
						},
					},
				},
			},
		},
	},
	pyright = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
				checkOnSave = true,
			},
		},
	},
	marksman = {},
	nil_ls = {},
	--
	-- Some languages (like typescript) have entire language plugins that can be useful:
	--    https://github.com/pmizio/typescript-tools.nvim
	--
	-- But for many setups, the LSP (`ts_ls`) will work just fine
	-- ts_ls = {},

	stylua = {}, -- Used to format Lua code

	-- Special Lua Config, as recommended by neovim help docs
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

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
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
					--  See https://github.com/neovim/nvim-lspconfig/issues/3189
					library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					}),
				},
			})
		end,
		---@type lspconfig.settings.lua_ls
		settings = {
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
}

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

-- Automatically install LSPs and related tools to stdpath for Neovim
require("mason").setup({})

-- Ensure the servers and tools above are installed
--
-- To check the current status of installed tools and/or manually install
-- other tools, you can run
--    :Mason
--
-- You can press `g?` for help in this menu.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	-- You can add other tools here that you want Mason to install
})

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
