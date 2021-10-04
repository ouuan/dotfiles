fun DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
        set filetype=gohtmltmpl
    endif
endfun
au BufRead * call DetectGoHtmlTmpl()
