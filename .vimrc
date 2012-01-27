" vim configuration file

" disable vi compatibility (emulation of old bugs)
" this must be first because it changes other options as a side effect
set nocompatible

" pathogen
call pathogen#infect()
"call pathogen#helptags()

" auto reload .vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" syntax highlighting
syntax on
set t_Co=256    " 256 colors
colors desert   " nice scheme
" allow backspace in insert mode
set backspace=indent,eol,start
" reload files changed outside Vim
set autoread
" no backup
set nobackup
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tab width and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" turn line numbers off
set nonumber
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" ensures that each window contains a status line
" that displays the current cursor position
set ruler
" display available entries on Tab
set wildmenu
" I don't want to edit binaries
set wildignore+=.git,*.o,*.pyc,*.png,*.jpg
" display partial commands
set showcmd
" status bar on last window
set laststatus=2
" special chars
set lcs=eol:¶,nbsp:·,tab:»\ ,trail:¤,extends:>,precedes:<
set list
" underline current line
set cursorline
" grep -C3 'current line' ;)
set scrolloff=3
" save folding
set foldmethod=marker
" 80 cols rules!
set textwidth=80
" display a foolproof vertical bar
if exists('+colorcolumn')
    set colorcolumn=+1  " textwidth + 1
    highlight ColorColumn ctermbg=darkgrey
endif
" persistent undo (7.3+)
if exists('+undofile')
    set undodir=~/.vim/undodir
    set undofile
endif

" Completion
" ctrl-space mapping
imap <Nul> <C-x><C-o>
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
set completeopt+=menu,longest
" change this unreadable pink bg
highlight Pmenu ctermbg=238

" laziness
command! Spell set spell spelllang=en
command! Ortho set spell spelllang=fr

" another Esc key
"inoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>
"inoremap <S-Tab> <Tab>
"vnoremap <S-Tab> <Tab>

" moving
noremap <BS> <PageUp>
noremap <Space> <PageDown>
noremap <Return> zz

" Command T
noremap <Tab> :CommandT<CR>
noremap <Tab><Tab> :CommandTBuffer<CR>

" bépo
if filereadable('.vimrc.bepo')
    source .vimrc.bepo
endif

"autocmd VimEnter * NERDTree

