local virtual_lines = false

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = not virtual_lines,
  virtual_lines = virtual_lines,
}

local lsp = require 'lspconfig'
local util = require 'lspconfig.util'

vim.keymap.set('n', 'H', '<cmd>echo "Hover is not available"<cr>', { desc = 'Hover is not available' })

local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  local function buf_set_keymap_capability(capability, mode, lhs, rhs, desc)
    if client.supports_method(capability) then
      buf_set_keymap(mode, lhs, rhs, desc)
    end
  end

  buf_set_keymap('n', '<leader>L', vim.diagnostic.open_float, 'Open diagnostics float')
  buf_set_keymap('n', '<leader>l', function()
    virtual_lines = not virtual_lines
    vim.diagnostic.config({ virtual_lines = virtual_lines, virtual_text = not virtual_lines })
  end, 'Toggle diagnostics display')

  buf_set_keymap_capability('hover', 'n', 'H', vim.lsp.buf.hover, 'Show hover')
  buf_set_keymap_capability('documentFormatting', 'n', '<leader>f', function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end, 'Format codes')
  buf_set_keymap_capability('documentRangeFormatting', 'x', '<leader>f', function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end, 'Format codes')

  buf_set_keymap_capability('definition', 'n', 'gd', '<cmd>Trouble lsp_definitions toggle<cr>')
  buf_set_keymap_capability('typeDefinition', 'n', 'gD', '<cmd>Trouble lsp_type_definitions toggle<cr>')
  buf_set_keymap_capability('references', 'n', 'gr', '<cmd>Trouble lsp_references toggle<cr>')
  buf_set_keymap_capability('implementation', 'n', 'gI', '<cmd>Trouble lsp_implementations toggle<cr>')

  buf_set_keymap_capability('rename', { 'n', 'x' }, '<leader>r', ':IncRename ', 'Rename (empty input)')
  if client.supports_method('rename') then
    vim.keymap.set({ 'n', 'x' }, '<leader>R', function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { buffer = bufnr, silent = true, desc = 'Rename (keep original)', expr = true })
  end

  buf_set_keymap_capability('codeAction', 'n', '<leader>ca', require 'actions-preview'.code_actions, 'Show code actions')
end

local no_setup_servers = {
  'cmake',
  'cssls',
  'dockerls',
  'gopls',
  'graphql',
  'html',
  'intelephense',
  'pyright',
  'r_language_server',
  'svelte',
  'texlab',
  'vimls',
  'yamlls',
}

local capabilities = require 'blink.cmp'.get_lsp_capabilities()

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
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = 'clippy',
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
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
      end
    }
  }
}

lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'clangd', '--background-index' },
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

lsp.ts_ls.setup {
  on_attach = del_format_attach,
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/lib/node_modules/@vue/typescript-plugin",
        languages = { "vue", "typescript", "javascript" },
      },
    },
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
}

lsp.eslint.setup {
  on_attach = add_format_attach,
  capabilities = capabilities,
  settings = {
    packageManager = 'pnpm',
  },
}

lsp.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'sh', 'zsh', 'PKGBUILD' }
}

lsp.lua_ls.setup {
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

lsp.veridian.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern('*.xpr', '*.qpf', '.git'),
}

lsp.stylelint_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    autoFixOnFormat = true,
  },
}

lsp.tinymist.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    formatterMode = 'typstyle',
  },
}

require 'crates'.setup {
  thousands_separator = ',',
  lsp = {
    enabled = true,
    on_attach = on_attach,
    actions = true,
    completion = true,
    hover = true,
  },
}
