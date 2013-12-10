set fileformat=unix "unix file endings
set encoding=utf-8
set nocompatible

"Vundle stuff
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"Github repos
Bundle 'majutsushi/tagbar'
Bundle 'jnwhiteh/vim-golang'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'itchyny/lightline.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/fountain.vim'
Bundle 'embear/vim-localvimrc'

"supetab configuration
let g:SuperTabMappingForward = "<nul>"
let g:SuperTabMappingBackward = "<s-tab>"

set t_Co=256
set background=dark "assume dark bg
colorscheme solarized

filetype plugin indent on

syntax enable "syntax highlighting
set cursorline

"LightLine configuration
let g:lightline = {
      \ 'colorscheme': 'solarized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

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
set rnu "Relative line numbering
set mouse=a "Enable mouse support in terminals that support it
set hlsearch "search results are highlighted

"ignore these extensions when expanding paths
set wildignore=*.o,*.pyc

let mapleader = "," "Set leader to ,

"Better buffer navigation
:set hidden
:nmap <Tab> :bn<CR>
:nmap <S-Tab> :bp<CR>

"Save as root
cmap w!! %!sudo tee > /dev/null %

"Wrap on column 80
nmap <silent> <leader>w :setlocal textwidth=80<CR>

"Remove search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

"leader t opens tags window
nmap <silent> <leader>t :TagbarToggle<CR>

"leader t opens NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>
"If only window left open is NERDTree, close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q 
"Yankstack binds
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

"shifting does not leave visual mode
vnoremap < <gv
vnoremap > >gv
