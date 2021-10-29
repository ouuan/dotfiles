vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
  },
  sources = {
    {
      name = 'nvim_lsp',
      priority = 100,
      max_item_count = 30,
    },
    {
      name = 'vsnip',
      priority = 99,
      max_item_count = 5,
    },
    {
      name = 'buffer',
      keyword_length = 3,
      max_item_count = 10,
    },
    {
      name = 'path',
      keyword_length = 2,
      max_item_count = 10,
    },
    {
      name = 'latex_symbols',
      keyword_length = 2,
      max_item_count = 20,
    },
    {
      name = 'look',
      keyword_length = 3,
      max_item_count = 10,
    },
  },
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
      cmp.TriggerEvent.InsertEnter,
    },
  },
  formatting = {
    deprecated = true,
    format = require'lspkind'.cmp_format({ with_text = true, maxwidth = 50 }),
  },
  experimental = {
    ghost_text = true,
  }
})

require'tabout'.setup {
  ignore_beginning = false,
  tabouts = {
    {open = "'", close = "'"},
    {open = '"', close = '"'},
    {open = '`', close = '`'},
    {open = '(', close = ')'},
    {open = '[', close = ']'},
    {open = '{', close = '}'},
    {open = '<', close = '>'},
  }
}
