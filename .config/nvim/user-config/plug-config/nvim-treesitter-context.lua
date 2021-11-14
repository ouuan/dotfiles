require'treesitter-context'.setup{
    enable = true,
    throttle = true,
    max_lines = 3,
    patterns = {
        -- For all filetypes
        default = {
            -- 'class',
            'function',
            'method',
            -- 'for',
            -- 'while',
            'if',
            'switch',
            'case',
        },
    },
}
