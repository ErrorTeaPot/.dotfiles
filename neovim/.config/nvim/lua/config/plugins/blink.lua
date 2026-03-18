return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    keymap = { preset = 'default' }, -- C-n/p, C-y, C-b/f, C-space
    appearance = {
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } }, -- remplace l'intégration autopairs+cmp
      documentation = { auto_show = true },

      trigger = {
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
      },
    },
    snippets = { preset = 'default' }, -- moteur de snippets intégré, LuaSnip non requis
  },
}
