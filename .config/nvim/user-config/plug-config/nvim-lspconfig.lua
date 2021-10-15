local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>CodeActionMenu<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  require'lsp_signature'.on_attach {
  }

  require'aerial'.on_attach(client);
  buf_set_keymap("n", "<leader>a", "<cmd>AerialOpen<cr>", opts)
end

local no_setup_servers = {
  'clangd',
  'vimls',
  'yamlls',
  'pyright',
  'cmake',
  'rust_analyzer',
  'texlab',
  'gopls',
  'intelephense',
  'graphql',
  'jdtls',
  'dockerls',
  'html',
  'cssls',
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
