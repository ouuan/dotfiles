require('gitsigns').setup({
    yadm = { enable = true },
    signs = {
        add          = {text= '┃', hl = 'GitSignsAdd'   },
        change       = {text= '┃', hl = 'GitSignsChange'},
        delete       = {text= '━', hl = 'GitSignsDelete'},
        topdelete    = {text= '━', hl = 'GitSignsDelete'},
        changedelete = {text= '≃', hl = 'GitSignsChange'},
    },
    keymaps = {
        noremap = true,
        buffer = true,

        ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n <leader>da'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>dA'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <leader>du'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>dU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
        ['n <leader>dr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>dR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>df'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>bl'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
    }
})
