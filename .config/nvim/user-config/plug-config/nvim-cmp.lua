vim.o.completeopt = "menu,menuone,noselect"

local cmp = require 'cmp'

cmp.setup({
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
  snippet = {
    expand = function(args)
      require 'luasnip'.lsp_expand(args.body)
    end
  },
  sources = {
    {
      name = 'zsh',
      priority = 100,
      max_item_count = 10,
    },
    {
      name = 'nvim_lsp',
      priority = 100,
    },
    {
      name = "copilot",
      priority = 50,
    },
    {
      name = 'luasnip',
      priority = 20,
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
  preselect = cmp.PreselectMode.None,
  formatting = {
    format = require 'lspkind'.cmp_format {
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = { Copilot = '' },
    },
  },
  experimental = {
    ghost_text = true,
  },
  sorting = {
    comparators = {
      require("copilot_cmp.comparators").prioritize,
      require("copilot_cmp.comparators").score,
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
  performance = {
    max_view_entries = 100,
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = {
    {
      name = 'buffer',
    }
  },
  performance = {
    max_view_entries = 10,
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = cmp.config.sources({
    {
      name = 'path',
    }
  }, {
    {
      name = 'cmdline',
    }
  }),
  performance = {
    max_view_entries = 20,
  },
})
