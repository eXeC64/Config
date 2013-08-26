set background=dark "assume dark bg
set fileformat=unix "unix file endings
set encoding=utf-8
set nocompatible

"Vundle stuff
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"Github repos
Bundle 'vim-scripts/taglist.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'vim-scripts/UltiSnips'
Bundle 'ervandew/supertab'
"supetab configuration
let g:SuperTabMappingForward = "<nul>"
let g:SuperTabMappingBackward = "<s-tab>"

filetype plugin indent on

syntax enable "syntax highlighting
"Adjust highlighting to make more sense
highlight Folded ctermfg=12 ctermbg=0
highlight Visual ctermfg=10 ctermbg=16 

"Auto go fmt go source files
au FileType go au BufWritePre <buffer> Fmt

"Auto-fold functions
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=0

set undolevels=1000
set showmode "show current mode in status line
set ruler "show cursor position in status line
set showcmd "show partial command in status line
set showmatch "show matching parenthesise

set clipboard=unnamed "yank to clipboard
set pastetoggle=<F12> "disable silly indenting on pastes

set tabstop=4 "Tabs are 4 spaces if they have to be tabs
set expandtab "tabs are spaces
set softtabstop=4
set autoindent "Autoindent by default
set copyindent "Indent to same level as previous line by default
set shiftwidth=4 "Number of spaces to autoindent
set shiftround "Use multiples of shiftwidth when using </> to indent

autocmd FileType make setlocal noexpandtab
autocmd Filetype go setlocal noexpandtab softtabstop=8 shiftwidth=8
autocmd Filetype html setlocal softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.md setlocal filetype=markdown

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
:nmap <A-w> :bd<CR>

"Save as root
cmap w!! %!sudo tee > /dev/null %

"Remove search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

"leader t opens tags window
nmap <silent> <leader>t :TlistToggle<CR>

"shifting does not leave visual mode
vnoremap < <gv
vnoremap > >gv

"Speed up scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
