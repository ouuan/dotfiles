local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        dynamic_preview_title = true,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        }
    }
}
