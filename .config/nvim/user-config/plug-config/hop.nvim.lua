local hop = require'hop'

hop.setup {
    keys = 'jfhgkdlsaurmvytnbiecowx'
}

for _,x in ipairs({'f', 'F', 't', 'T'}) do
  vim.keymap.set({'n', 'v', 'o'}, x, hop.hint_char1)
end
