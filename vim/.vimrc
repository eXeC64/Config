"Harry "eXeC64" Jeffery's vimrc.
"Current version available in github.com/eXeC64/Config
"Use zo/zc to open and close the folds
" vim: fdm=indent

"==============="
"Native settings"
"==============="
  set fileformat=unix                                 "Unix file endings
  set encoding=utf-8                                  "Use the blessed utf-8 encoding
  set nocompatible                                    "Don't bother with silly vi compatibility
  set undolevels=1000                                 "Undo up to 1000 times
  set backspace=indent,eol,start                      "Backspace can go back over anything
  set clipboard=unnamed                               "Enable yank to clipboard
  set mouse=a                                         "Enable mouse support (Not that I use it much)
  set scroll=10                                       "Set C-u/c-d scroll distance
  set wildignore=*.o,*.pyc,*.so,*.swp,*.zip,*Build/*  "Ignore these extensions when expanding paths
  set modeline                                        "Allow files to set vim settings
  let mapleader = ","                                 "Set leader to ','

  "Set up console colours
  set t_Co=256
  set background=dark

  "Solarized colour settings
  colorscheme solarized
  highlight SignColumn ctermbg=8

  "Highlighting
  syntax enable                         "Syntax highlighting
  set showmatch                         "Highlight matching parenthesise
  set hlsearch                          "Highlight search results
  set cursorline                        "Highlight the line the cursor is on

  "Statusbar and line numbering
  set laststatus=2                      "Statusbar should be double height
  set showmode                          "Show current mode in status line
  set showcmd                           "Show partial command in status line
  set ruler                             "Show cursor position in status line
  set nu                                "Enable line numbering...
  set rnu                               " ...but make it relative

  "Indentation
  set expandtab                         "Tabs are spaces
  set tabstop=2                         "Tab size
  set softtabstop=2                     "How much to indent by when you hit tab.
  set shiftwidth=2                      "Shift indentation amount (>> and <<)
  set autoindent                        "Autoindent by default
  set copyindent                        "Indent to same level as previous line by default
  set shiftround                        "Use multiples of shiftwidth when using </> to indent

  "GVim
  set guioptions-=m                     "Remove menu bar
  set guioptions-=T                     "Remove toolbar
  set guioptions-=r                     "Remove right hand scrollbar
  set guioptions-=L                     "Remove left hand scrollbar
  set guifont=Monospace\ 11             "Set font in gui

"========================="
"Custom binds and commands
"========================="
  "Remove search highlighting
  nmap <silent> <leader>/ :nohlsearch<CR>

  "Shifting keeps us in visual mode
  vnoremap < <gv
  vnoremap > >gv

  "A hack to save as root if we forgot to use vim as root
  cmap w!! %!sudo tee > /dev/null %

"=========================="
"Filetype specific settings
"=========================="
  autocmd FileType make setlocal noexpandtab
  autocmd Filetype go setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype html setlocal softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.md setlocal filetype=markdown spell spelllang=en_gb
  au BufRead,BufNewFile *.fountain setlocal filetype=fountain linebreak spell spelllang=en_gb

"==============="
"Vundle settings"
"==============="
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Bundle 'gmarik/Vundle.vim'

  Bundle  'altercation/vim-colors-solarized'
  Bundle       'embear/vim-localvimrc'
  Bundle     'jnwhiteh/vim-golang'
  Bundle         'kien/ctrlp.vim'
  Bundle     'Lokaltog/vim-easymotion'
  Bundle 'maxbrunsfeld/vim-yankstack'
  Bundle   'scrooloose/syntastic'
  Bundle        'tpope/vim-markdown'
  Bundle  'vim-scripts/fountain.vim'
  Bundle        'tpope/vim-fugitive'
  Bundle        'bling/vim-airline'
  Bundle       'edsono/vim-matchit'
  Bundle        'tpope/vim-commentary'
  Bundle       'SirVer/ultisnips'
  Bundle       'eXeC64/my-snippets'
  Bundle   'majutsushi/tagbar'

  call vundle#end()
  filetype plugin indent on

"==============="
"Plugin settings"
"==============="
  "Local vimrc
  let g:localvimrc_ask = 0              "Don't ask to use a local .vimrc, do it automatically.

  "CtrlP
  :set hidden                           "Don't stop us switching away from unsaved files
  let g:ctrlp_map = '<c-p>'             "Bind to ctrl-p
  let g:ctrlp_cmd = 'CtrlP'             "Default command
  let g:ctrlp_working_path_mode = 'ra'  "Default to head of repo, or current working directory
  let g:ctrlp_max_files = 0             "Don't limit how many files to scan
  let g:ctrlp_max_depth = 40            "Don't go farther than 40 levels deep into a directory
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:30'

  nmap <silent> <leader>b :CtrlPBuffer<CR>
  nmap <silent> <leader>r :CtrlPMRU<CR>
  nmap <silent> <leader>d :CtrlPCurWD<CR>

  "Yankstack binds
  nmap <leader>p <Plug>yankstack_substitute_older_paste
  nmap <leader>P <Plug>yankstack_substitute_newer_paste

  "Syntastic options
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'

  "Ultisnip options
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

  "Tagbar
  nmap <silent> <leader>t :TagbarToggle<CR>
  let g:tagbar_autoclose = 1        "Autoselect the tagbar window, and auto close on tag selection
  let g:tagbar_show_linenumbers = 1 "Show relative line numbers, for easy jumping

  "Airline
  let g:airline_section_warning = '' "We don't want any warnings, thanks.
  let g:airline_powerline_fonts = 1 "Use patched fonts

  "Commenting
  map <C-C> gcc
  vmap <C-C> gc

"====="
"Cheat sheet
"====="
  "This is stuff I need to get into the habbit of using.
  "
  "EasyMotion:
  "<leader><leader><motion> to show prompt for quick jumping.
  "
  "Marks:
  "m<letter> to set a mark
  "'<letter> to go to a mark
