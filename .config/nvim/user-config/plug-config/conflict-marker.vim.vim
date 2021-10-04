let g:conflict_marker_enable_mappings = 0
nmap <leader>ct <Plug>(conflict-marker-themselves)
nmap <leader>co <Plug>(conflict-marker-ourselves)
nmap <leader>cn <Plug>(conflict-marker-none)
nmap <leader>cb <Plug>(conflict-marker-both)
nmap <leader>cB <Plug>(conflict-marker-both-rev)
nmap ]c <Plug>(conflict-marker-next-hunk)
nmap [c <Plug>(conflict-marker-prev-hunk)

let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
