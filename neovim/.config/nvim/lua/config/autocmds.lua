-- start in your face autocmd
--[[
local IN_YOUR_FACE_PATH = vim.fn.stdpath 'config' .. '/assets/inyourface'
local IN_YOUR_FACE_TERM = nil
-- Autocmd for DiagnosticChanged to echo numbers of errors
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local diagnostics = args.data.diagnostics
    -- get count of errors
    local errors = 0
    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        errors = errors + 1
      end
    end

    local imgnum = 0
    if errors > 5 then
      imgnum = 3
    elseif errors > 3 then
      imgnum = 2
    elseif errors > 0 then
      imgnum = 1
    end

    local cmd = 'cat ' .. IN_YOUR_FACE_PATH .. '/doom' .. imgnum .. '.txt'

    if IN_YOUR_FACE_TERM ~= nil then
      IN_YOUR_FACE_TERM:close()
      IN_YOUR_FACE_TERM:destroy()
      IN_YOUR_FACE_TERM = nil
    end
    IN_YOUR_FACE_TERM = require('snacks').terminal.open(cmd, {
      interactive = false,
      win = {
        style = 'terminal',
        row = -3,
        col = -1,
        enter = false,
        backdrop = false,
        width = 16,
        height = 16,
      },
    })
  end,
})
-- end in your face autocmd
]]
--
local restore_cursor_augroup = vim.api.nvim_create_augroup('restore_cursor_shape_on_exit', { clear = true })

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  group = restore_cursor_augroup,
  desc = 'restore the cursor shape on exit of neovim',
  command = 'set guicursor=a:ver20',
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
