vim.diagnostic.config {
  severity_sort = true
}

local lsp = require 'lspconfig'
local util = require 'lspconfig.util'

vim.keymap.set('n', 'H', '<cmd>echo "Hover is not available"<cr>', { desc = 'Hover is not available' })

local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  local function buf_set_keymap_capability(capability, mode, lhs, rhs, desc)
    if client.server_capabilities[capability .. 'Provider'] then
      buf_set_keymap(mode, lhs, rhs, desc)
    end
  end

  buf_set_keymap('n', '<leader>l', vim.diagnostic.open_float, 'Show diagnostics')

  buf_set_keymap_capability('hover', 'n', 'H', vim.lsp.buf.hover, 'Show hover')
  buf_set_keymap_capability('documentFormatting', 'n', '<leader>f', vim.lsp.buf.format, 'Format codes')
  buf_set_keymap_capability('documentRangeFormatting', 'x', '<leader>f', vim.lsp.buf.format, 'Format codes')

  buf_set_keymap('n', '<leader>x', '<cmd>TroubleToggle document_diagnostics<cr>')
  buf_set_keymap('n', '<leader>X', '<cmd>TroubleToggle workspace_diagnostics<cr>')
  buf_set_keymap_capability('definition', 'n', 'gd', '<cmd>TroubleToggle lsp_definitions<cr>')
  buf_set_keymap_capability('typeDefinition', 'n', 'gD', '<cmd>TroubleToggle lsp_type_definitions<cr>')
  buf_set_keymap_capability('references', 'n', 'gr', '<cmd>TroubleToggle lsp_references<cr>')
  buf_set_keymap_capability('implementation', 'n', 'gI', '<cmd>TroubleToggle lsp_implementations<cr>')

  local rename = require 'renamer'.rename;
  local rename_empty = function(empty)
    return function()
      rename { empty = empty }
    end
  end
  buf_set_keymap_capability('rename', { 'n', 'x' }, '<leader>r', rename_empty(true), 'Rename (empty input)')
  buf_set_keymap_capability('rename', { 'n', 'x' }, '<leader>R', rename_empty(false), 'Rename (keep original)')

  buf_set_keymap_capability('codeAction', 'n', '<leader>ca', require 'actions-preview'.code_actions, 'Show code actions')

  if client.server_capabilities.colorProvider then
    require 'document-color'.buf_attach(bufnr)
  end

  if client.server_capabilities.signatureHelpProvider then
    require 'lsp_signature'.on_attach {
      auto_close_after = 3,
    }
  end
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

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

for _, server in pairs(no_setup_servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name

    if string.find(path, 'verifyingkernel') then
      client.config.settings['rust-analyzer'].checkOnSave.overrideCommand = { 'verus', '--expand-errors' }
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end

    return true
  end,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
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

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = 'utf-8'
lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { 'clangd', '--background-index' },
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

lsp.matlab_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern('.git', '*.m'),
}
