require 'gitsigns'.setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '━' },
    topdelete    = { text = '━' },
    changedelete = { text = '≃' },
    untracked    = { text = '╏' },
  },
  signs_staged_enable = false,
  _on_attach_pre = function(bufnr, callback)
    require 'gitsigns-yadm'.yadm_signs(callback, { bufnr = bufnr })
  end,
  sign_priority = 20,
  max_file_length = 10000,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Next Git hunk' })

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Previous Git hunk' })

    -- Actions
    map({ 'n', 'x' }, '<leader>da', '<cmd>Gitsigns stage_hunk<CR>')
    map('n', '<leader>dA', gs.stage_buffer, { desc = 'Git state buffer' })
    map('n', '<leader>du', gs.undo_stage_hunk, { desc = 'Undo Git stage' })
    map({ 'n', 'x' }, '<leader>dr', '<cmd>Gitsigns reset_hunk<CR>')
    map('n', '<leader>dR', gs.reset_buffer, { desc = 'Git reset buffer' })
    map('n', '<leader>df', gs.preview_hunk, { desc = 'Git Preview hunk' })
    map('n', '<leader>bl', function() gs.blame_line { full = true } end, { desc = 'Git blame line' })

    local diffthis = function(base)
      gs.diffthis(base)
      vim.cmd('wincmd h')
      vim.bo.buflisted = false
      vim.b.vimtex_enabled = 0
    end

    map('n', '<leader>dF', diffthis, { desc = 'Git diff buffer' })
    map('n', '<leader>dh', function() diffthis('~') end, { desc = 'Git diff against HEAD' })

    -- Text object
    map({ 'o', 'x' }, 'ih', '<cmd>Gitsigns select_hunk<CR>')
  end,
}
