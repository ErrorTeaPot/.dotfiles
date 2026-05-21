-- Configuration LSP minimale pour Neovim 0.10+
-- Utilise uniquement l'API native de Neovim

-- Configuration basique des diagnostics
vim.diagnostic.config({
  virtual_text = true,  -- Affiche les erreurs dans le texte
  signs = true,         -- Affiche les icônes dans la gouttière
  update_in_insert = false,
})

-- Configuration de base pour un serveur LSP (exemple avec Lua)
-- Remplacez par le serveur que vous utilisez réellement
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.lsp.start({
      name = 'lua-language-server',
      cmd = { 'lua-language-server' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'init.lua' }, { upward = true })[1]),
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        },
      },
    })
  end
})

-- Mappings de base pour les fonctionnalités LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    
    -- Définition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = 'Aller à la définition' })
    
    -- Documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = 'Documentation' })
    
    -- Navigation entre diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts, { desc = 'Diagnostic précédent' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts, { desc = 'Diagnostic suivant' })
  end
})