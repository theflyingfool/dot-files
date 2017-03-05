"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" ~/.vimrc
"
" https://git.theflyingfool.com/theflyingfool/dot/blob/master/vim/vimrc
"
" Maintainer:
"	TheFlyingFool - tff@theflyingfool.com
"	http://theflyingfool.com
"
" Version:
"	Mon Mar 16 19:37:55 CDT 2015
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual Settings
set ruler
" Show Line Number
set nu
" make :w!! do a sudo save
cmap w!! w !sudo tee > /dev/null %

" Search settings
"	Searches as you type
"	Ignores case while searching
"	If case specified only search that
"	Highlight search results
"	Forces VIM instead of Vi
set incsearch
set ignorecase
set smartcase
set hlsearch
set nocompatible 
filetype off


" Load Vundle
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'

" Plugins must be loaded before following two lines
"call vundle#end()
filetype plugin indent on

" Syntax Highlighting  
" 	Forces .md files to load as Markdown
syntax on
au BufRead,BufNewFile *.md set filetype=markdown

"Turns on Spell Check
:setlocal spell spelllang=en_us


" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" fix some common typos
iabbrev waht what
iabbrev tehn then

set modeline
