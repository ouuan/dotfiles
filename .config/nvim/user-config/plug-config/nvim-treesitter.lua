require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    ignore_install = {
      'perl', -- failed to download 🤔
    },
    highlight = {
        enable = true,
        disable = {
            'bash',
            'c',
            'latex',
        },
    },
}
