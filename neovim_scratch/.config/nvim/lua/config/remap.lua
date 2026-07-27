-- KEYMAPS
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`
vim.g.mapleader = ' '

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- LSP Keymaps for diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
