set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set scrolloff=10
set smartcase ignorecase
set lazyredraw
set confirm
set list
set listchars=tab:\ \ |
set hidden
set exrc
set secure
set wildmode=longest:full,full
set updatetime=300
set number relativenumber
set mouse=a
set splitbelow
set splitright
set termguicolors
set colorcolumn=+1
set foldlevel=100000
set foldmethod=indent
set cursorline

filetype plugin on

command! -bar -nargs=1 Tab setlocal tabstop=<args> | setlocal shiftwidth=<args>

command! -bar Cd cd %:p:h

au FileType vim set fo-=o fo-=r

au FileType json,javascript,css,gohtmltmpl,vue,typescript,lua Tab 2

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
        " https://github.com/dstein64/nvim-scrollview/issues/10
        silent! ScrollViewDisable
        bd
        silent! ScrollViewEnable
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

nmap <silent> J :bnext<cr>
nmap <silent> K :bprev<cr>

" next/prev diff
nnoremap ]d ]c
nnoremap [d [c

" swap wrong quotes
nnoremap <leader>q l?”<cr>r“/“<cr>r”:noh<cr>

" Restore cursor shape on VimLeave
au VimLeave * set guicursor=a:ver1

call plug#begin('~/.config/nvim/plugged')

Plug 'ouuan/vim-plug-config'
let g:plug_config_vim_dir = stdpath('config') . "/user-config/plug-config"
let g:plug_config_lua_dir = stdpath('config') . "/user-config/plug-config"
command -nargs=0 P PlugClean | PlugConfigClean | PlugUpdate

" put it in a separate line to prevent commenting it out and being hard to revert
Plug 'tpope/vim-commentary'

Plug 'nvim-lua/plenary.nvim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5', 'for': ['markdown', 'gitcommit', 'scratch', 'text'] }
Plug 'Chiel92/vim-autoformat'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-repeat'
Plug 'mcchrish/nnn.vim'
Plug 'kana/vim-textobj-user'
Plug 'takac/vim-hardtime'
Plug 'kana/vim-textobj-entire'
Plug 'm-pilia/vim-pkgbuild'
Plug 'fatih/vim-go'
Plug 'neovim/nvim-lspconfig'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'bkad/CamelCaseMotion'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ojroques/nvim-hardline', { 'branch': 'main' }
Plug 'tpope/vim-fugitive'
Plug 'folke/lsp-trouble.nvim', { 'branch': 'main' }
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'phaazon/hop.nvim'
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
Plug 'svermeulen/vimpeccable'
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
Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main' }
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }
Plug 'kdheepak/cmp-latex-symbols', { 'branch': 'main' }
Plug 'octaltree/cmp-look'
Plug 'kosayoda/nvim-lightbulb'
Plug 'ahmedkhalf/project.nvim', { 'branch': 'main' }
Plug 'lewis6991/spellsitter.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ruifm/gitlinker.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'luukvbaal/stabilize.nvim'
Plug 'filipdutescu/renamer.nvim'
Plug 'romgrk/nvim-treesitter-context'

call plug#end()
