set fileformat=unix "unix file endings
set encoding=utf-8
set nocompatible

"Vundle stuff
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

"Github repos
Bundle 'jnwhiteh/vim-golang'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-markdown'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/fountain.vim'
Bundle 'embear/vim-localvimrc'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on

"supetab configuration
let g:SuperTabMappingForward = "<nul>"
let g:SuperTabMappingBackward = "<s-tab>"

set t_Co=256
set background=dark "assume dark bg
colorscheme solarized


syntax enable "syntax highlighting

set laststatus=2

"vim-git-inline-diff column background colour
highlight SignColumn ctermbg=8

"lvimrc should not ask first
let g:localvimrc_ask = 0

set undolevels=1000
set showmode "show current mode in status line
set ruler "show cursor position in status line
set showcmd "show partial command in status line
set showmatch "show matching parenthesise

set clipboard=unnamed "yank to clipboard

set expandtab "tabs are spaces
set tabstop=4
set softtabstop=4
set autoindent "Autoindent by default
set copyindent "Indent to same level as previous line by default
set shiftwidth=4 "Number of spaces to autoindent
set shiftround "Use multiples of shiftwidth when using </> to indent

autocmd FileType make setlocal noexpandtab
autocmd Filetype go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype html setlocal softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.md setlocal filetype=markdown spell spelllang=en_gb
au BufRead,BufNewFile *.fountain setlocal filetype=fountain linebreak spell spelllang=en_gb

set backspace=indent,eol,start "Backspace can go back over anything
set nu "Line numbering
set rnu "Relative line numbering
set mouse=a "Enable mouse support in terminals that support it
set hlsearch "search results are highlighted

"ignore these extensions when expanding paths
set wildignore=*.o,*.pyc,*.so,*.swp,*.zip

let mapleader = "," "Set leader to ,

"Better buffer navigation
:set hidden
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:30'

"ctrlp between buffers
nmap <silent> <leader>b :CtrlPBuffer<CR>

"ctrlp recent files
nmap <silent> <leader>r :CtrlPMRU<CR>

"ctrlp current file's directory
nmap <silent> <leader>f :CtrlPCurFile<CR>
"
"ctrlp the current working directory
nmap <silent> <leader>d :CtrlPCurWD<CR>

"Don't limit ctrlp's file access
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40

"Save as root
cmap w!! %!sudo tee > /dev/null %

"Remove search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

"Yankstack binds
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

"shifting does not leave visual mode
vnoremap < <gv
vnoremap > >gv

"Syntastic options

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

"Set C-u/C-d jump distance
set scroll=10
