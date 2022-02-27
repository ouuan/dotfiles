set colorcolumn=+1
set confirm
set cursorline
set expandtab
set exrc
set foldlevel=100000
set foldmethod=indent
set hidden
set lazyredraw
set list
set listchars=tab:\ \ |
set mouse=a
set number relativenumber
set scrolloff=10
set secure
set shiftround
set shiftwidth=4
set smartcase ignorecase
set smartindent
set smarttab
set splitbelow
set splitright
set tabstop=4
set termguicolors
set updatetime=300
set wildmode=longest:full,full

filetype plugin on

command! -bar -nargs=1 Tab setlocal tabstop=<args> | setlocal shiftwidth=<args>

command! -bar Cd cd %:p:h

au FileType vim set fo-=o fo-=r

au FileType json,javascript,css,html,gohtmltmpl,vue,typescript,lua,xml Tab 2

au FileType markdown set suffixesadd+=.md

" fstab
au BufEnter fstab* Tab 8 \| setlocal ft=fstab \| setlocal noexpandtab \| setlocal tw=0

let mapleader=' '

fun! s:IsOnlyWindow()
    return len(filter(getwininfo(), '!has_key(v:val.variables, "scrollview_key") && !has_key(v:val.variables, "treesitter_context")')) == 1
endfun

fun! ConfirmQuit()
    if exists('g:confirm_quit') && s:IsOnlyWindow()
        if confirm("Do you really want to quit?", "&Yes\n&No", 2) == 1
            quit
        endif
    else
        quit
    endif
endfun

fun! CloseOrQuit()
    " detect tab at first because of Signify Diff
    if len(gettabinfo()) > 1
        tabclose
    elseif len(getbufinfo({'buflisted':1})) > 1
        " https://github.com/neovim/neovim/issues/13628
        silent! TSContextDisable
        silent! ScrollViewDisable
        bd
        silent! ScrollViewEnable
        silent! TSContextEnable
    elseif s:IsOnlyWindow()
        call ConfirmQuit()
    else
        quit
    endif
endfun

nmap <leader>s :w<cr>
nmap <silent> q :call CloseOrQuit()<cr>
nmap <silent> Q :call ConfirmQuit()<cr>
nmap <silent> ZZ <space>sQ
au CmdwinEnter * nmap <silent> q :q<cr>
au CmdwinLeave * nmap <silent> q :call CloseOrQuit()<cr>

" use m for macro because q is used for quit
nnoremap m q
nnoremap M m

" use <leader><cr> to clear the search highlight
nmap <leader><cr> :noh<cr>

" Run PlugInstall if there are missing plugins
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC | call CloseOrQuit()
            \| endif

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-h> :wincmd h<cr>
nmap <silent> <c-j> :wincmd j<cr>
nmap <silent> <c-k> :wincmd k<cr>
nmap <silent> <c-l> :wincmd l<cr>

" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
inoremap <c-r> <c-r><c-p>

" https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character
xnoremap $ g_

nmap <silent> J :bnext<cr>
nmap <silent> K :bprev<cr>

" next/prev diff
nnoremap ]d ]c
nnoremap [d [c

" swap wrong quotes
nnoremap <leader>q l?”<cr>r“/“<cr>r”:noh<cr>

" https://gist.github.com/ouuan/909f25f18a74d9e04e1e0881d3316905
au BufEnter translated-words.txt nnoremap <silent> gt :silent exec "!xdg-open https://fanyi.baidu.com/\\#auto/zh/<cWORD>"<cr>

" Restore cursor shape on VimLeave
au VimLeave * set guicursor=a:ver1

call plug#begin('~/.config/nvim/plugged')

Plug 'ouuan/vim-plug-config'
let g:plug_config_vim_dir = stdpath('config') . "/user-config/plug-config"
let g:plug_config_lua_dir = stdpath('config') . "/user-config/plug-config"
command -nargs=0 P PlugClean | PlugConfigClean | PlugUpdate

" put it in a separate line to prevent commenting it out and being hard to revert
Plug 'numToStr/Comment.nvim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'

Plug 'nvim-lua/plenary.nvim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5', 'for': ['markdown', 'gitcommit', 'scratch', 'text', 'tex'] }
Plug 'Chiel92/vim-autoformat'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-repeat'
Plug 'mcchrish/nnn.vim'
Plug 'takac/vim-hardtime'
Plug 'kana/vim-textobj-entire'
Plug 'm-pilia/vim-pkgbuild'
Plug 'fatih/vim-go'
Plug 'neovim/nvim-lspconfig'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'bkad/CamelCaseMotion'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ojroques/nvim-hardline', { 'branch': 'main' }
Plug 'tpope/vim-fugitive'
Plug 'folke/lsp-trouble.nvim', { 'branch': 'main' }
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'ouuan/hop.nvim', { 'branch': 'fix-inclusive' }
Plug 'folke/which-key.nvim', { 'branch': 'main' }
Plug 'rktjmp/lush.nvim', { 'branch': 'main' }
Plug 'npxbr/gruvbox.nvim', { 'branch': 'main' }
Plug 'pchynoweth/vim-gencode-cpp', { 'for': 'cpp' }
Plug 'nacitar/a.vim', { 'for': 'cpp' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nacro90/numb.nvim'
Plug 'cespare/vim-toml'
Plug 'junegunn/goyo.vim'
Plug 'psliwka/vim-smoothie'
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ray-x/lsp_signature.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'branch': 'main' }
Plug 'farmergreg/vim-lastplace'
Plug 'rhysd/conflict-marker.vim'
Plug 'andymass/vim-matchup'
Plug 'AndrewRadev/splitjoin.vim', { 'branch': 'main' }
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mboughaba/i3config.vim'
Plug 'tommcdo/vim-exchange'
Plug 'kevinhwang91/nvim-hlslens', { 'branch': 'main' }
Plug 'stevearc/aerial.nvim'
Plug 'stevearc/stickybuf.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'oberblastmeister/neuron.nvim', { 'branch': 'unstable' }
Plug 'othree/html5.vim'
Plug 'David-Kunz/treesitter-unit', { 'branch': 'main' }
Plug 'leafOfTree/vim-vue-plugin'
Plug 'Julian/lean.nvim', { 'branch': 'main' }
Plug 'tami5/sqlite.lua'
Plug 'AckslD/nvim-neoclip.lua', { 'branch': 'main' }
Plug 'weilbith/nvim-code-action-menu', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main' }
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }
Plug 'kdheepak/cmp-latex-symbols', { 'branch': 'main' }
Plug 'octaltree/cmp-look'
Plug 'onsails/lspkind-nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'ahmedkhalf/project.nvim', { 'branch': 'main' }
Plug 'lewis6991/spellsitter.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ruifm/gitlinker.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'luukvbaal/stabilize.nvim'
Plug 'filipdutescu/renamer.nvim'
Plug 'romgrk/nvim-treesitter-context'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
" Plug 'petertriho/nvim-scrollbar', { 'branch': 'main' }
Plug 'jubnzv/virtual-types.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'j-hui/fidget.nvim', { 'branch': 'main' }
Plug 'danymat/neogen', { 'branch': 'main' }
Plug 'AndrewRadev/switch.vim'
Plug 'rbong/vim-buffest'
Plug 'tamago324/cmp-zsh', { 'branch': 'main' }

call plug#end()
