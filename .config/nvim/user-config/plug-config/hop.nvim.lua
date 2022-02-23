local hop = require'hop'

hop.setup {
  keys = 'jfhgkdlsaurmvytnbiecowx'
}

for _,x in ipairs({'f', 'F'}) do
  vim.keymap.set({'n', 'v', 'o'}, x, hop.hint_char1)
end

for _,x in ipairs({'t', 'T'}) do
  vim.keymap.set({'n', 'v', 'o'}, x, function() hop.hint_char1({ inclusive_jump = false }) end)
end
