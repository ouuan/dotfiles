local hop = require'hop'

hop.setup {
    keys = 'jfhgkdlsaurmvytnbiecowx'
}

-- for _,x in ipairs({'f', 'F'}) do
--     require'vimp'.bind('nvo', {}, x, function() hop.hint_char1{ inclusive_jump = true } end)
-- end

for _,x in ipairs({'f', 'F', 't', 'T'}) do
    require'vimp'.bind('nvo', {}, x, hop.hint_char1)
end
