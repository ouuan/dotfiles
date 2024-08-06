require 'actions-preview'.setup {
  highlight_command = {
    require 'actions-preview.highlight'.delta('delta --hunk-header-style=omit --file-style=omit --paging=never --line-numbers-left-format="" --line-numbers-right-format=""'),
  },
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}
