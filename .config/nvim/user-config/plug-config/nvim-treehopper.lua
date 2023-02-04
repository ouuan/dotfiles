local tsht = require 'tsht'

tsht.config.hint_keys = {
  "j", "f", "h", "g", "k", "d", "l", "s", "a",
  "u", "r", "m", "v", "y", "t", "n", "b", "i",
  "e", "c", "o", "w", "x"
}

vim.keymap.set({ 'n', 'o' }, 'T', tsht.nodes)
