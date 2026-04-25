require 'nvim-treesitter-textobjects'.setup {
}

local function set_keymap(key, pattern)
  vim.keymap.set(
    {'x', 'o'},
    key,
    function ()
      require 'nvim-treesitter-textobjects.select'.select_textobject(pattern, 'textobjects')
    end
  )
end

set_keymap('af', '@function.outer')
set_keymap('if', '@function.inner')
set_keymap('aa', '@parameter.outer')
set_keymap('ia', '@parameter.inner')
