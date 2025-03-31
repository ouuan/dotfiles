set colorcolumn=+1
set confirm
set cursorline
set expandtab
set exrc
set fileencodings=utf-8,gb2312,gbk,gb18030,ucs-bom
set foldlevel=100000
set foldmethod=indent
set hidden
set lazyredraw
set list
set listchars=tab:\ \ |
set mouse=a
set number relativenumber
set scrolloff=10
set shiftround
set shiftwidth=4
set smartcase ignorecase
set smarttab
set splitbelow
set splitkeep=screen
set splitright
set tabstop=4
set termguicolors
set undofile
set updatetime=300
set wildmode=longest:full,full

filetype plugin on

command! -bar -nargs=1 Tab setlocal tabstop=<args> shiftwidth=<args>

command! -bar Cd cd %:p:h

au FileType vim set fo-=o fo-=r

au FileType bib,css,gohtmltmpl,html,javascript,json,lua,scss,systemverilog,toml,typescript,typst,vue,xml Tab 2

au FileType markdown set suffixesadd+=.md
au FileType systemverilog set suffixesadd+=.sv commentstring=//\ %s
au FileType typst set commentstring=//\ %s

au BufNewFile,BufRead *.mdx set filetype=markdown
au BufNewFile,BufRead *.phar set filetype=php
au BufNewFile,BufRead *.vh set filetype=systemverilog
au BufNewFile,BufRead *.zsh-theme set filetype=zsh
au BufNewFile,BufRead Makefrag set filetype=make

let mapleader=' '

fun! CloseOrQuit()
    if len(getbufinfo({'buflisted':1})) > 1
        bd
    else
        quit
    endif
endfun

nmap <leader>s <cmd>w<cr>
nmap <leader>e <cmd>e<cr>
nmap <silent> q <cmd>call CloseOrQuit()<cr>
nmap <silent> Q <cmd>qall<cr>
nmap <silent> ZZ <space>sQ
au CmdwinEnter * nmap <silent> q <cmd>q<cr>
au CmdwinLeave * nmap <silent> q <cmd>call CloseOrQuit()<cr>

" use m for macro because q is used for quit
nnoremap m q
nnoremap M m

" use <leader><cr> to clear the search highlight
nmap <leader><cr> <cmd>noh\|echo<cr>

" Run PlugInstall if there are missing plugins
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC | call CloseOrQuit()
            \| endif

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-h> <cmd>wincmd h<cr>
nmap <silent> <c-j> <cmd>wincmd j<cr>
nmap <silent> <c-k> <cmd>wincmd k<cr>
nmap <silent> <c-l> <cmd>wincmd l<cr>

" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
inoremap <c-r> <c-r><c-p>

" https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character
xnoremap $ g_

nmap <silent> J <cmd>bnext<cr>
nmap <silent> K <cmd>bprev<cr>

aug hidebufs
    au!
    au FileType qf setlocal nobuflisted
aug END

" next/prev diff
nnoremap ]d ]c
nnoremap [d [c

" https://gist.github.com/ouuan/909f25f18a74d9e04e1e0881d3316905
au BufEnter translated-words.txt nnoremap <silent> gt <cmd>silent exec "!xdg-open https://fanyi.baidu.com/\\#auto/zh/<cWORD>"<cr>

" Restore cursor shape on VimLeave
au VimLeave * set guicursor=a:ver1

fun! ManMapping()
    nnoremap <buffer> q <cmd>qall<cr>
    nnoremap <buffer> gd <cmd>Man \| call ManMapping()<cr>
endfun

fun! ManPager()
    Man!
    let width = expand('$MANWIDTH') + 2 " +2 for scrollbar
    if &columns > width + 2 " +2 for windows of width 1 on both sides
        for i in ['topleft', 'botright']
            execute i . ' ' . ((&columns - width) / 2) . 'vnew'
            setlocal ft=padding buftype=nofile nomodifiable nobuflisted nonumber norelativenumber foldcolumn=0 signcolumn=no nocursorline
            wincmd p
        endfor
    end
    set fillchars=vert:\ ,eob:\  winwidth=1
    call ManMapping()
endfun

" don't use pyenv for neovim Python host
let g:python3_host_prog = '/usr/bin/python3'

call plug#begin('~/.config/nvim/plugged')

let g:plug_config_vim_dir = stdpath('config') . "/user-config/plug-config"
let g:plug_config_lua_dir = stdpath('config') . "/user-config/plug-config"
Plug 'ouuan/vim-plug-config'

" better than the builtin one and folke/ts-comments.nvim
Plug 'numToStr/Comment.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'kylechui/nvim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5', 'for': ['markdown', 'gitcommit', 'scratch', 'text', 'tex', 'typst'] }
Plug 'vim-autoformat/vim-autoformat'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'neovim/nvim-lspconfig'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'folke/lsp-trouble.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ouuan/hop.nvim', { 'branch': 'fix-inclusive' }
Plug 'folke/which-key.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'pchynoweth/vim-gencode-cpp', { 'for': 'cpp' }
Plug 'nacitar/a.vim', { 'for': 'cpp' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nacro90/numb.nvim'
Plug 'cespare/vim-toml'
Plug 'psliwka/vim-smoothie'
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ray-x/lsp_signature.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'andymass/vim-matchup'
Plug 'ntpeters/vim-better-whitespace'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'haya14busa/vim-asterisk'
Plug 'stevearc/stickybuf.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'othree/html5.vim'
Plug 'Julian/lean.nvim'
Plug 'tami5/sqlite.lua'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'iguanacucumber/magazine.nvim', { 'as': 'nvim-cmp' }
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'octaltree/cmp-look'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
Plug 'tamago324/cmp-zsh'
Plug 'onsails/lspkind-nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'dstein64/nvim-scrollview'
Plug 'machakann/vim-highlightedyank'
Plug 'j-hui/fidget.nvim'
Plug 'danymat/neogen'
Plug 'Wansmer/treesj'
Plug 'm00qek/baleia.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'andythigpen/nvim-coverage'
Plug 'nvimtools/none-ls.nvim'
Plug 'luukvbaal/nnn.nvim'
Plug 'folke/flash.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'bullets-vim/bullets.vim'
Plug 'ruifm/gitlinker.nvim'
Plug 'lambdalisue/suda.vim'
Plug 'aznhe21/actions-preview.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'gbprod/substitute.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'purarue/yadm-git.vim'
Plug 'purarue/gitsigns-yadm.nvim'
Plug 'chomosuke/typst-preview.nvim'
Plug 'vladdoster/remember.nvim'
Plug 'brenoprata10/nvim-highlight-colors'
Plug 'typicode/bg.nvim'
Plug 'arp242/undofile_warn.vim'
Plug 'ouuan/nvim-bigfile'
Plug 'sontungexpt/url-open'
Plug 'ZWindL/orphans.nvim'
Plug 'smjonas/inc-rename.nvim'
Plug 'petRUShka/vim-sage'
Plug 'nvzone/volt'
Plug 'nvzone/typr'
Plug 'nvim-lualine/lualine.nvim'
Plug 'stevearc/aerial.nvim'

call plug#end()
