
set background=dark "assume dark bg
set fileformat=unix "unix file endings
syntax enable "syntax highlighting

set undolevels=1000
set showmode "show current mode in status line
set ruler "show cursor position in status line
set showcmd "show partial command in status line
set showmatch "show matching parenthesise

set clipboard=unnamed "yank to clipboard
set pastetoggle=<F12> "disable silly indenting on pastes

set expandtab "tabs are spaces
set softtabstop=4
set autoindent "Autoindent by default
set copyindent "Indent to same level as previous line by default
set shiftwidth=4 "Number of spaces to autoindent
set shiftround "Use multiples of shiftwidth when using </> to indent

au FileType Makefile set noexpandtab "makefiles are tabs, not spaces!

set backspace=indent,eol,start "Backspace can go back over anything

set rnu "Relative line numbering

set mouse=a "Enable mouse support in terminals that support it

set gdefault "Search/replace is global on a line by default
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

"j/k go up/down rows on wrapped lines, instead of to next line
nnoremap j gj
nnoremap k gk

"Remove search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

"shifting does not leave visual mode
vnoremap < <gv
vnoremap > >gv

"Speed up scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

