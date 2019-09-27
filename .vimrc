set shellslash " for fugitive
execute pathogen#infect()
set nocompatible
filetype plugin indent on
set encoding=utf-8

syntax enable
if has("gui_running")
    set lines=40
    set columns=80
else
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    set t_Co=256
endif
colorscheme solarized
set background=light
set guifont=Consolas:h12

set showcmd
set showmode
set hidden
let mapleader=" "
let maplocalleader=" "
inoremap jk <esc>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>s i<space><Esc>la<space><Esc>
nnoremap <leader>m i$<Esc>Ea$<Esc>
nnoremap , %
vnoremap , %
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
nnoremap <silent> <C-l> :nohl<CR><C-l>    " clear highlighting

" Select previously pasted text
nnoremap <leader>v V`]
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set number
set pastetoggle=<F2>

set textwidth=120
set list
set listchars=tab:»·,trail:·
set backspace=indent,eol,start
set ruler
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set hlsearch
set incsearch
set wildmenu
set history=1000
set undolevels=1000
set wildignore=*.swp,*.pyc,*.class
set title
set nobackup
set noswapfile

autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_gb
autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_gb

let g:syntastic_python_checkers = ['python3', 'flake8']
let g:syntastic_python_flake8_post_args = '--ignore=E501,E126,E123,E226,E231,F841,W503,E731'

set autochdir
