":helptags ~/.vim/pack/colors/opt/everforest/doc/ ========================================
" Appearance & UI
" ========================================

" True colors
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has ('termguicolors')
  set termguicolors
endif

" Syntax highlighting
syntax on

" Colorscheme
call plug#begin(expand('~/.vim/plugged'))
Plug 'arcticicestudio/nord-vim'
call plug#end()

set background=dark
let g:everforest_background = 'soft'
let g:everforest_better_performance = 1

colorscheme everforest

" Sync clipboard with OS
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif


" Use a line cursor within insert mode and a block cursor everywhere else.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
