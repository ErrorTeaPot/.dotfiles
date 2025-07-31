return {
  'danymat/neogen',
  config = function()
    -- Initialize Neogen
    require('neogen').setup {
      snippet_engine = 'luasnip', -- or 'vsnip' or 'snippy' or 'none'
    }

    -- Set up key mapping
    vim.keymap.set('n', '<Leader>cd', require('neogen').generate, { desc = 'Generate code documentation' })
  end,
}
