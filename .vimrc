" pretty colors
syntax on

" light up the darkness
set background=light " go light then dark to totally force dark setting
set background=dark

" show line numbers
set number

" show cursor position in status bar
set ruler

" tab should be 4 spaces
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround

" auto-indent on new line
set autoindent

" key mappings to move between split windows with Alt-arrow
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" highlight 80th column for line length
set colorcolumn=80

" makes vim more useful
set nocp

" more useful autocompletion
set wildmode=list:longest

" scroll when within 3 lines of window edge
set scrolloff=3

" automatically detect the file type based on extension
filetype plugin on

" unix file formatting ftw
set fileformat=unix

" pathogen
call pathogen#infect()

" allow backspace to delete indenting, EOL, and over the start of insert
" thanks josh davis (github.com/jdavis/dotfiles/.vimrc)
set backspace=indent,eol,start

" map leader key to comma, because backslash sucks
let mapleader = ","

" Autoclose Plugin options
let g:AutoClosePairs = "() {} [] \" ' `"
au FileType html,php,xhtml,xml,xrc let g:AutoClosePairs_del = "<>""'
