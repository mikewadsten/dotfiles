"
" Global Settings
"

" Need moar history
set history=1000

" show line numbers
set number

" pretty colors
syntax on

" light up the darkness
set background=light " go light then dark to totally force dark setting
set background=dark

" Vundle requirement
filetype off

" show cursor position in status bar
set ruler

" tab should be 4 spaces
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround

" auto-indent on new line
set autoindent

" persistent undo
set undodir=~/.vim/undodir
set undofile

" makes vim more useful
set nocp

" more useful autocompletion
set wildmode=list:longest

" scroll when within 3 lines of window edge
set scrolloff=3

" unix file formatting ftw
set fileformat=unix

" allow backspace to delete indenting, EOL, and over the start of insert
" thanks josh davis (github.com/jdavis/dotfiles/.vimrc)
set backspace=indent,eol,start

set cursorline

" highlight 80th column for line length
set colorcolumn=80

" Auto save on focus lost.
au FocusLost * :wa

" map leader key to comma, because backslash sucks
let mapleader = ","

" search improvements
set ignorecase smartcase
set hlsearch
set incsearch
set showmatch

" Show the current command at the bottom
set showcmd

" Necessary for crap
set laststatus=2
set encoding=utf-8


"
" Fancy colors
"

highlight ExtraWhitespace ctermbg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
nnoremap <leader>qq :ConqueTermVSplit bash<CR>

highlight cursorline cterm=NONE ctermbg=Black

hi colorcolumn ctermbg=DarkBlue


"
" Key mappings
"

" move between split windows with Alt-arrow
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" map <leader>d to delete to black hole register
nnoremap <leader>d "_dd
vnoremap <leader>d "_dd

" map <leader>w to remove trailing whitespace across file
nnoremap <leader>w :%s/\s\+$//e<CR>
vnoremap <leader>w :%s/\s\+$//e<CR>

" I use tabs now. Tabs are cool.
nnoremap <silent> <leader>tt :tabnew<CR>
nnoremap <silent> <leader>tp :tabprev<CR>
nnoremap <silent> <leader>tn :tabnext<CR>
nnoremap <silent> <leader>tq :tabclose<CR>

" Toggle NERDTree
nmap <leader>b :NERDTreeTabsToggle<CR>

" Vundle mappings
nmap <leader>vl :BundleList<CR>
nmap <leader>vi :BundleInstall<CR>
nmap <leader>vI :BundleInstall!<CR>
nmap <leader>vc :BundleClean<CR>
nmap <leader>vC :BundleClean!<CR>

" Clear search highlighting
nmap <leader>/ :nohlsearch<CR>

" Make up/down jump to next line in editor, not file
nmap <Up> g<Up>
nmap <Down> g<Down>

" ack.vim
noremap <leader>a :Ack <cword><CR>
noremap <leader>A :Ack<Space>

" map leader-s to search for the word under cursor
noremap <silent> <leader>s :exe "/".expand("<cword>")<CR>

" Save keystrokes
nnoremap ; :

" Show yank-ring contents
nnoremap <silent> <F9> :YRShow<CR>


"
" Bundle/Vundle settings
"

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Required
Bundle 'gmarik/vundle'

" Auto close pairs of characters
Bundle 'Townk/vim-autoclose'

" Truly orgasmic comment management
Bundle 'scrooloose/nerdcommenter'

" Surroundings characters
Bundle 'tpope/vim-surround'

" Python syntax and PEP8 checking. Requires easy_install flake8
Bundle 'nvie/vim-flake8'

" Tab completion
Bundle 'ervandew/supertab'

" File browsing
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" ack-vim
Bundle 'mileszs/ack.vim'

" a.vim - switch between header and source files easily
Bundle 'vim-scripts/a.vim'

" Yank ring
Bundle 'vim-scripts/YankRing.vim'

" Powerline, because why not
Bundle 'Lokaltog/vim-powerline'


"
" Plugin settings
"

" flake8 ignores
let g:flake8_ignore="E501,W802"

" Autoclose Plugin options
let g:AutoClosePairs = "() {} [] \" ' `"
au FileType html,php,xhtml,xml,xrc let g:AutoClosePairs_del = "<>""'

let g:ConqueTerm_CloseOnEnd = 1

let g:Powerline_symbols = 'compatible'

" Load plugins and indent for the filetype
filetype plugin indent on
