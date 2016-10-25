if 0  " has('nvim')
  let s:plug_path = '~/.nvim/autoload/plug.vim'
else
  let s:plug_path = '~/.vim/autoload/plug.vim'
endif

if empty(glob(s:plug_path))
    echo "Looks like the first time setup for vim-plug..."
    silent exe '!curl -fLo ' . s:plug_path ' --create-dirs ' .
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/personal/dotfiles/dotvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
let g:commentary_map_backslash = 0
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/matchit'
call plug#end()
