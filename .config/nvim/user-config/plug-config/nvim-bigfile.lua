require 'bigfile'.setup {
  ft_size_limits = {
    javascript = 100 * 1024,
    json = 200 * 1024,
  },
}
