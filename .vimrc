set shellslash " for fugitive
execute pathogen#infect()
set nocompatible
filetype plugin indent on
set encoding=utf-8

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'reasonml-editor/vim-reason-plus'
call plug#end()

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
set background=dark
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
nnoremap <leader>yt :MerlinTypeOf<CR>:MerlinYankLatestType<CR>
nmap <LocalLeader>r  <Plug>(MerlinRename)
nmap <LocalLeader>R  <Plug>(MerlinRenameAppend)
nmap <leader>en <Plug>(ale_next_wrap)
nmap <leader>eN <Plug>(ale_previous_wrap)
nnoremap <leader>ez :ALEDetail<CR>
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
set wildmode=longest,list,full
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
autocmd BufRead,BufNewFile *.txt hi SpellBad cterm=underline
autocmd BufRead,BufNewFile *.tex hi SpellBad cterm=underline
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_gb
autocmd BufRead,BufNewFile *.md hi SpellBad cterm=underline



let g:syntastic_python_checkers = ['python3', 'flake8']
let g:syntastic_python_flake8_post_args = '--ignore=E501,E126,E123,E226,E231,F841,W503,E731'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\   'reason': ['refmt'],
\   'ocaml': ['ocamlformat'],
\}

let g:ale_linters = {
\   'ocaml': ['merlin'],
\}
let g:ale_python_flake8_options = '--ignore=E501,E203'

let g:ale_fix_on_save = 1

let g:ale_completion_enabled = 0

let g:LanguageClient_serverCommands = {
    \ 'reason': ['~/.vim/rls-linux/reason-language-server']
    \ }

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> <leader>t :call LanguageClient#textDocument_hover()<cr>
  endif
endfunction

autocmd FileType * call LC_maps()


set autochdir
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
