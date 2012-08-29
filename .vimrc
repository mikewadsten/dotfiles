syntax on               " syntax highlighting "
set background=dark     " bright colors! "
set tabstop=4           " make tab = 4 spaces "
set expandtab           " tab turns to spaces "
set shiftwidth=4        " something about tabs "
set shiftround          " automatically tab to interval of 4? "
set autoindent          " auto-indent on new line "
set number              " show line numbers "
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
set colorcolumn=80      " highlight 80th column for line length "
set nocp
set wildmode=list:longest " more useful autocomplete 
set scrolloff=3 " more context around cursor when scrolling
filetype plugin on
set ruler
set fileformat=unix
