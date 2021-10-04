let g:far#enable_undo = 1
let g:far#source = 'rg'
let g:far#glob_mode = 'rg'
let g:far#default_file_mask = '/**'
let g:far#ignore_files = ['.gitignore']
let g:far#mode_open = { "regex": 1, "case_sensitive": 1, "word": 0, "substitute": 0 }
let g:far#preview_window_height = 15

nmap <silent> <leader>h :Farr<cr>
vmap <silent> <leader>h :Farr<cr>
