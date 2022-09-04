vim.diagnostic.config {
  severity_sort = true
}

local lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  buf_set_keymap('n', 'gD', vim.lsp.buf.declaration)
  buf_set_keymap('n', 'gd', vim.lsp.buf.definition)
  buf_set_keymap('n', 'H', vim.lsp.buf.hover)
  buf_set_keymap('n', '<leader>D', vim.lsp.buf.type_definition)
  buf_set_keymap({ 'n', 'v' }, '<leader>rn', function() require("renamer").rename({ empty = true }) end)
  buf_set_keymap("n", '<leader>rf', "<cmd>TroubleToggle lsp_references<cr>")
  buf_set_keymap('n', '<leader>l', vim.diagnostic.open_float)

  if client.server_capabilities.codeActionProvider then
    buf_set_keymap('n', '<leader>ca', '<cmd>CodeActionMenu<cr>')
  end

  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end)
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap("v", "<leader>f", vim.lsp.buf.range_formatting)
  end

  if client.server_capabilities.colorProvider then
    require 'document-color'.buf_attach(bufnr)
  end

  require 'lsp_signature'.on_attach {
    auto_close_after = 3,
  }

  require 'aerial'.on_attach(client);
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
  'svelte',
  'texlab',
  'vimls',
  'yamlls',
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in pairs(no_setup_servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      }
    }
  }
}

local snippetcaps = vim.lsp.protocol.make_client_capabilities()
snippetcaps.textDocument.completion.completionItem.snippetSupport = true

lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  }
}

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = "utf-8"
lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index" },
  capabilities = clangd_capabilities,
}

local add_format_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  on_attach(client, bufnr)
end

local del_format_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  on_attach(client, bufnr)
end

lsp.tsserver.setup {
  on_attach = del_format_attach,
  capabilities = capabilities,
}

lsp.volar.setup {
  on_attach = del_format_attach,
  capabilities = capabilities,
}

lsp.eslint.setup {
  on_attach = add_format_attach,
  capabilities = capabilities,
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
  capabilities = capabilities,
  filetypes = { "sh", "zsh", "PKGBUILD" }
}

lsp.sumneko_lua.setup {
  cmd = { '/usr/bin/lua-language-server' },
  on_attach = on_attach,
  capabilities = capabilities,
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
        globals = { 'vim' },
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
