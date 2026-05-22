-- Configuration des onglets natifs de Neovim

-- Mappings pour les onglets
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Nouvel onglet" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Fermer onglet" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Gardier seulement cet onglet" })
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "Déplacer onglet" })

-- Navigation entre onglets
vim.keymap.set("n", "<leader>1", "1gt", { desc = "Onglet 1" })
vim.keymap.set("n", "<leader>2", "2gt", { desc = "Onglet 2" })
vim.keymap.set("n", "<leader>3", "3gt", { desc = "Onglet 3" })
vim.keymap.set("n", "<leader>4", "4gt", { desc = "Onglet 4" })
vim.keymap.set("n", "<leader>5", "5gt", { desc = "Onglet 5" })
vim.keymap.set("n", "<leader>6", "6gt", { desc = "Onglet 6" })
vim.keymap.set("n", "<leader>7", "7gt", { desc = "Onglet 7" })
vim.keymap.set("n", "<leader>8", "8gt", { desc = "Onglet 8" })
vim.keymap.set("n", "<leader>9", "9gt", { desc = "Onglet 9" })
vim.keymap.set("n", "<leader>0", ":tablast<CR>", { desc = "Dernier onglet" })

-- Navigation avec gt/gT améliorée
vim.keymap.set("n", "<C-h>", "gT", { desc = "Onglet précédent" })
vim.keymap.set("n", "<C-l>", "gt", { desc = "Onglet suivant" })

-- Configuration de l'apparence des onglets
vim.opt.showtabline = 2 -- Toujours afficher la ligne d'onglets
vim.opt.tabpagemax = 50 -- Nombre maximum d'onglets

-- Fonction pour renommer un onglet
function RenameTab()
	local new_name = vim.fn.input("Nouveau nom pour l'onglet: ")
	if new_name ~= "" then
		vim.cmd("tabrename " .. new_name)
	end
end

vim.keymap.set("n", "<leader>tr", RenameTab, { desc = "Renommer onglet" })

-- Auto-command pour donner des noms par défaut aux onglets
vim.api.nvim_create_autocmd("TabNew", {
	callback = function()
		local bufname = vim.fn.bufname(vim.fn.tabpagebuflist()[1])
		if bufname ~= "" then
			vim.cmd("tabrename " .. vim.fn.fnamemodify(bufname, ":t"))
		end
	end,
})

