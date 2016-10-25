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

" let g:SuperTabDefaultCompletionType = "<c-n>"

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

Plug 'justinmk/vim-dirvish'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'ervandew/supertab'

Plug 'embear/vim-localvimrc'
call plug#end()

" Total hack
augroup mikeInitReloadPlugins
  autocmd!
  " After each write to this init.vim file, source it.
  let s:plugins_file_path = resolve(expand('<sfile>:p'))
  execute 'autocmd! BufWritePost ' . s:plugins_file_path . " source " . s:plugins_file_path
augroup END
