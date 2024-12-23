local header = {
  [[]],
  [[]],
  [[]],
  [[████████╗███████╗ █████╗ ██████╗  ██████╗ ████████╗]],
  [[╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝]],
  [[   ██║   █████╗  ███████║██████╔╝██║   ██║   ██║   ]],
  [[   ██║   ██╔══╝  ██╔══██║██╔═══╝ ██║   ██║   ██║   ]],
  [[   ██║   ███████╗██║  ██║██║     ╚██████╔╝   ██║   ]],
  [[   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝    ╚═╝   ]],
  [[]],
  [[]],
  [[]],
}

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = header,
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
