" vim configuration file

" pathogen
call pathogen#infect()

" auto reload .vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" syntax highlighting
syntax on
"set t_Co=256    " 256 colors
colors desert   " nice scheme
" disable vi compatibility (emulation of old bugs)
set nocompatible
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
" display partial commands
set showcmd
" status bar on last window
set laststatus=2
" special chars
set lcs=eol:¶,nbsp:·,tab:»\ ,trail:¤,extends:>,precedes:<
set list
" underline current line
set cursorline
" hide mouse when unused
"set mousehide
" grep -C3 'current line' ;)
set scrolloff=3
" save folding
set foldmethod=marker
" flash instead of beep on error
set vb t_vb=
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" 80 cols rules!
set textwidth=80
" display a foolproof vertical bar
if exists('+colorcolumn')
    set colorcolumn=+1  " textwidth + 1
    highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
else
    "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
" Todo color for trailing whitespace
"match Todo /\s\+$/
" persistent undo (v7.3+)
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
"highlight Pmenu ctermbg=238
"set ofu=syntaxcomplete#Complete
"au filetype html        set omnifunc=htmlcomplete#CompleteTags
"au filetype css         set omnifunc=csscomplete#CompleteCSS
"au filetype javascript  set omnifunc=javascriptcomplete#CompleteJS
"au filetype c           set omnifunc=ccomplete#Complete
"au filetype php         set omnifunc=phpcomplete#CompletePHP
"au filetype ruby        set omnifunc=rubycomplete#Complete
"au filetype sql         set omnifunc=sqlcomplete#Complete
"au filetype python      set omnifunc=pythoncomplete#Complete
"au filetype xml         set omnifunc=xmlcomplete#CompleteTags
"if !filereadable('tags')
"    imap <Nul> <C-n>
"endif

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

" web browser into Vim!
fun! OpenWebBrowser(address)
    exe "split"
    exe "enew"
    exe "set buftype=nofile"
    echo "reading " . a:address
    exe "silent r!elinks -dump " . a:address
    syn reset
    "add some syntax rules (thanks to jamesson on #vim)
    syn match Keyword /\[\d*\]\w*/ contains=Ignore
    syn match Ignore /\[\d*\]/ contained
    exe "norm gg"
endfun

com! -nargs=+ WebBrowser call OpenWebBrowser(<q-args>)

vmap ,g :call OpenWebBrowser("http://www.google.com/search?hl=en&q=<C-R><C-W>")<CR>
vmap ,w :call OpenWebBrowser("http://en.wikipedia.org/wiki/<C-R><C-W>")<CR>
vmap ,b :call OpenWebBrowser("<C-R><C-A>")<CR>

" bépo
if filereadable('.vimrc.bepo')
    source .vimrc.bepo
endif

"autocmd VimEnter * NERDTree

