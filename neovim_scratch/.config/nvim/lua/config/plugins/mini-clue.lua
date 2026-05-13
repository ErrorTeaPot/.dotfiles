vim.pack.add({'https://github.com/nvim-mini/mini.clue'})
require('mini.clue').setup {
  window = {
    delay = 0,
  },
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
  },
  clues = {
    -- Clues intégrées pour les commandes natives utiles
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows(),
    require('mini.clue').gen_clues.z(),
  },
}
