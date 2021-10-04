let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
let g:nnn#set_default_mappings = 0

fun! NnnPickCurrent()
    if @% == ""
        NnnPicker
    else
        NnnPicker %:p
    endif
endfun

nmap <leader>n :call NnnPickCurrent()<cr>
