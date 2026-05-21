vim.pack.add({'https://github.com/nvim-mini/mini.clue'})

local miniclue = require('mini.clue')

miniclue.setup {
  window = {
    delay = 0,
  },
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
  },
  clues = {
    -- Clues intégrées pour les commandes natives utiles
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    
    -- Nos clues personnalisées par groupes
    { mode = 'n', keys = '<Leader>f', desc = '+Find (Telescope)' },
    { mode = 'n', keys = '<Leader>t', desc = '+Tabs' },
  },
}
