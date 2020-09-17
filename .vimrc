" Vim configuration file for Louis
" Pulled from 
" https://realpython.com/vim-and-python-a-match-made-in-heaven/#vim-extensions

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
"Bundle 'Valloric/YouCompleteMe'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'flazz/vim-colorschemes'

" after adding the plugin, type ':PluginInstall' on the VIM CLI

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set indentation settings
set expandtab
set tabstop=4
set shiftwidth=4

" See line numbers
set number

" Set utf-8 encoding
set encoding=utf-8

" Adding PEP 8 format for .py files
au BufNewFile,BufRead *.py
    \ set softtabstop=4 | 
    \ set textwidth=69 | 
    \ set autoindent | 
    \ set fileformat=unix

" Set colors to 256
set t_Co=256

" Syntax highlighting
let python_highlight_all=1
syntax on
colorscheme antares

" Use VIM in the python shell
" set editing-mode vi

" Flag unnecessary whitespace in code
" highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
" highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/

" Enable folding
set foldmethod=indent
set foldlevel=99

" See docstrings while folded
let g:SimpylFold_docstring_preview=1

" Auto-complete settings - make window go away when done
let g:ycm_autoclose_preview_window_after_completion=1
" Map '<space>-g' to go to definition of function call
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" For virtualenvs and using goto definition
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF

" --- Key Maps --- 
" switching between files
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" fold with the spacebar
nnoremap <space> za
