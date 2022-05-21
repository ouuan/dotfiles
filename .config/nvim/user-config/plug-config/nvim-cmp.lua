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
      name = 'zsh',
      priority = 200,
      max_item_count = 10,
    },
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
      keyword_length = 2,
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
      max_item_count = 30,
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
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = {
    {
      name = 'buffer',
      max_item_count = 10,
    }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = cmp.config.sources({
    {
      name = 'path',
      max_item_count = 15,
    }
  }, {
    {
      name = 'cmdline',
      max_item_count = 15,
    }
  })
})
