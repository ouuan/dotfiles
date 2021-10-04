local hop = require'hop'

hop.setup {
    keys = 'jfhgkdlsaurmvytnbiecowx'
}

for _,x in ipairs({'f', 't', 'F', 'T'}) do
    require'vimp'.bind('nvo', {}, x, hop.hint_char1)
end
