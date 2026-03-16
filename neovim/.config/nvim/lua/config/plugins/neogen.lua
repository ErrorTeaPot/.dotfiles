return {
  'danymat/neogen',
  config = function()
    -- Initialize Neogen
    require('neogen').setup {
      snippet_engine = 'nvim',
    }
    -- Set up key mapping
    vim.keymap.set('n', '<Leader>cd', require('neogen').generate, { desc = 'Generate code documentation' })
  end,
}
