require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  ignore_install = {
    'perl', -- failed to download 🤔
    'ipkg', -- error: not in gzip format
  },
  highlight = {
    enable = true,
    disable = {
      'bash',
      'c',
      'latex',
    },
  },
  indent = {
    enable = true,
  },
}
