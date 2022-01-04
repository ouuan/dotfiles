require'treesitter-context'.setup{
    enable = true,
    throttle = true,
    max_lines = 4,
    patterns = {
        -- For all filetypes
        default = {
            -- 'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'elif',
            'else',
            'switch',
            'case',
        },
    },
}
