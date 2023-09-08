local hop = require'hop'

hop.setup {
  keys = 'jfhgkdlsaurmvytnbiecowx'
}

for _,x in ipairs({'f', 'F'}) do
  vim.keymap.set({'n', 'x', 'o'}, x, hop.hint_char1)
end

vim.keymap.set({'n', 'x', 'o'}, 't', function() hop.hint_char1({ inclusive_jump = false }) end)
