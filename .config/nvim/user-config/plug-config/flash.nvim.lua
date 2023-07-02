local flash = require 'flash'

flash.setup {
  labels = 'jfhgkdlsaurmvytnbiecowx',
  jump = {
    autojump = true,
  },
  modes = {
    char = {
      enabled = false,
    },
    search = {
      enabled = false,
    },
    treesitter = {
      labels = 'jfhgkdlsaurmvytnbiecowx',
    },
  },
}

-- https://github.com/folke/flash.nvim/issues/47
--
-- local char = require 'flash.plugins.char'
--
-- for _, motion in ipairs({ 'f', 't', 'F' }) do
--   vim.keymap.set({ 'n', 'x', 'o' }, motion, function()
--     flash.jump({
--       mode = 'char',
--       search = {
--         mode = char.mode(motion),
--         wrap = true,
--       },
--     }, char.motions[motion])
--   end)
-- end

vim.keymap.set({ 'n', 'x', 'o' }, 'T', flash.treesitter)

vim.keymap.set('o', 'r', flash.remote)
