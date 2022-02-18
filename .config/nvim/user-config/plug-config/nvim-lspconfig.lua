local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  buf_set_keymap('n', 'gD', vim.lsp.buf.declaration)
  buf_set_keymap('n', 'gd', vim.lsp.buf.definition)
  buf_set_keymap('n', 'H', vim.lsp.buf.hover)
  -- buf_set_keymap('n', 'gi', vim.lsp.buf.implementation)
  buf_set_keymap('n', '<leader>D', vim.lsp.buf.type_definition)
  buf_set_keymap({'n', 'v'}, '<leader>rn', function() require("renamer").rename({ empty = true }) end)
  -- buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action)
  buf_set_keymap('n', '<leader>ca',  '<cmd>CodeActionMenu<cr>')
  -- buf_set_keymap({'n', 'v'}, 'gr', vim.lsp.buf.references)
  buf_set_keymap("n", '<leader>rf', "<cmd>TroubleToggle lsp_references<cr>")

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", vim.lsp.buf.formatting)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>f", vim.lsp.buf.range_formatting)
  end
  if client.resolved_capabilities.code_lens then
    require'virtualtypes'.on_attach()
  end

  require'lsp_signature'.on_attach {
    auto_close_after = 3,
  }

  require'aerial'.on_attach(client);
  buf_set_keymap("n", "<leader>a", "<cmd>AerialOpen<cr>")
end

local no_setup_servers = {
  'cmake',
  'cssls',
  'dockerls',
  'gopls',
  'graphql',
  'html',
  'intelephense',
  'jdtls',
  'pyright',
  'rust_analyzer',
  'svelte',
  'texlab',
  'vimls',
  'yamlls',
}

for _,server in pairs(no_setup_servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end

local snippetcaps = vim.lsp.protocol.make_client_capabilities()
snippetcaps.textDocument.completion.completionItem.snippetSupport = true

lsp.jsonls.setup {
  on_attach = on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index" },
}

local add_format_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  on_attach(client, bufnr)
end

local del_format_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  on_attach(client, bufnr)
end

lsp.tsserver.setup {
  on_attach = del_format_attach,
}

lsp.volar.setup {
  on_attach = del_format_attach,
}

lsp.eslint.setup {
  on_attach = add_format_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
}

lsp.bashls.setup {
  on_attach = on_attach,
  filetypes = { "sh", "zsh", "PKGBUILD" }
}

lsp.sumneko_lua.setup {
  cmd = {'/usr/bin/lua-language-server'},
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
