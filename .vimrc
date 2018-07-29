" vim configuration file

" disable vi compatibility (emulation of old bugs)
" this must be first because it changes other options as a side effect
set nocompatible

" auto reload .vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" syntax highlighting
syntax on
set t_Co=256    " 256 colors

" solarized settings
let g:solarized_termcolors=256 " force to use 256 colors
let g:solarized_termtrans=1 " fix bg color with urxvt
set background=dark
" set background=light
colorscheme solarized

" don't redraw while executing macros (good performance config)
set lazyredraw
" for regular expressions turn magic on
set magic
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
set number
set relativenumber
" highlight matching braces
set showmatch
" smart Emacs-style search
set incsearch
set ignorecase
set smartcase
set hlsearch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" ensures that each window contains a status line
" that displays the current cursor position
set ruler
" display available entries on Tab
set wildmenu
" don't want to edit binaries and temp files
set wildignore+=*.o,*.pyc,*.png,*.jpg,.git,doc,log,tmp,elm-stuff
" display partial commands
set showcmd
" special chars
set lcs=eol:¶,nbsp:·,tab:»\ ,trail:¤,extends:>,precedes:<
set list
" underline current line
set cursorline
" grep -C3 'current line' ;)
set scrolloff=3
" keep 5 columns next to the cursor when scrolling horizontally
set sidescrolloff=5
" save folding
set foldmethod=marker
" 80 cols rules!
set textwidth=80
" display a foolproof vertical bar
set colorcolumn=+1  " textwidth + 1
highlight ColorColumn ctermbg=darkgrey
" persistent undo
set undodir=~/.vim/undodir
set undofile
autocmd! BufNewFile /var/tmp/* setlocal undolevels=-1
autocmd! BufNewFile /tmp/* setlocal undolevels=-1

" Completion
" ctrl-space mapping
imap <Nul> <C-x><C-o>
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
set completeopt+=menu,longest
" don't scan included files - tags file is more performant
set complete-=i
" change this unreadable pink bg
highlight Pmenu ctermbg=238

" Y yanks from the cursor to the end of line as expected
nnoremap Y y$

" laziness
command! Spell set spell spelllang=en
command! Ortho set spell spelllang=fr
highlight SpellBad cterm=underline

" custom shortcuts
let mapleader = "\\"
nmap <Leader>\ :call NERDComment('n', 'Toggle')<CR>
nmap <Leader>a :wa<CR>
nmap <Leader>c :nohlsearch<CR>
nmap <Leader>m :Dispatch<CR>
nmap <Leader>n :NERDTreeFocus<CR>
nmap <Leader>p :set paste!<CR>
nmap <Leader>q :q<CR>
nmap <Leader>t :TagbarToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>x :x<CR>

" moving
noremap <BS> <PageUp>
noremap <Space> <PageDown>
noremap <Return> zz
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" plugins settings
"" Tagbar
let g:tagbar_compact = 1

"" completor
let g:completor_gocode_binary = '/home/infertux/go/bin/gocode'

"" fzf
nmap <Tab> :FZF<CR>

"" NERDTree
let g:NERDTreeWinSize=20
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=[
\ '\~$', '\.*\.sw.$',
\ '.bundle[[dir]]', '.git[[dir]]', '.sass-cache[[dir]]', '.yardoc[[dir]]',
\ 'node_modules[[dir]]'
\]

"" elm
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

" misc
"au BufRead,BufNewFile *.scss set filetype=css
"autocmd VimEnter * NERDTree

" vim:set ft=vim et sw=2:
