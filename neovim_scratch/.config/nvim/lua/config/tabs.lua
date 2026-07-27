-- Configuration des onglets natifs de Neovim

-- Mappings pour les onglets
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "[T]ab [C]lose" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "[T]ab [O]nly (close others)" })
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "[T]ab [M]ove" })

-- Navigation entre onglets
vim.keymap.set("n", "<leader>1", "1gt", { desc = "Go to tab 1" })
vim.keymap.set("n", "<leader>2", "2gt", { desc = "Go to tab 2" })
vim.keymap.set("n", "<leader>3", "3gt", { desc = "Go to tab 3" })
vim.keymap.set("n", "<leader>4", "4gt", { desc = "Go to tab 4" })
vim.keymap.set("n", "<leader>5", "5gt", { desc = "Go to tab 5" })
vim.keymap.set("n", "<leader>6", "6gt", { desc = "Go to tab 6" })
vim.keymap.set("n", "<leader>7", "7gt", { desc = "Go to tab 7" })
vim.keymap.set("n", "<leader>8", "8gt", { desc = "Go to tab 8" })
vim.keymap.set("n", "<leader>9", "9gt", { desc = "Go to tab 9" })
vim.keymap.set("n", "<leader>0", ":tablast<CR>", { desc = "Go to last tab" })

-- Navigation avec gt/gT améliorée
vim.keymap.set("n", "<C-h>", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "<C-l>", "gt", { desc = "Next tab" })

-- Configuration de l'apparence des onglets
vim.opt.showtabline = 2 -- Toujours afficher la ligne d'onglets
vim.opt.tabpagemax = 50 -- Nombre maximum d'onglets

-- Fonction pour renommer un onglet
local function RenameTab()
	local new_name = vim.fn.input("Nouveau nom pour l'onglet: ")
	if new_name ~= "" then
		vim.cmd("tabrename " .. new_name)
	end
end

vim.keymap.set("n", "<leader>tr", RenameTab, { desc = "[T]ab [R]ename" })

-- Auto-command pour donner des noms par défaut aux onglets
vim.api.nvim_create_autocmd("TabNew", {
	callback = function()
		local bufname = vim.fn.bufname(vim.fn.tabpagebuflist()[1])
		if bufname ~= "" then
			vim.cmd("tabrename " .. vim.fn.fnamemodify(bufname, ":t"))
		end
	end,
})

