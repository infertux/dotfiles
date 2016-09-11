
set tabstop=2        " tab width is 2 spaces
set shiftwidth=2     " indent also with 2 spaces

" Set up automatic formatting
set formatoptions+=tcqlro

" Jump to matching bracket for 3/10th of a second (works with showmatch)
set matchtime=3
set showmatch

" Enable folding of class/function blocks
"let php_folding = 1
" Do not use short tags to find PHP blocks
let php_noShortTags = 1
" Highlight SQL inside PHP strings
let php_sql_query=1
" Highlight HTML inside PHP strings
let php_htmlInStrings=1

" Use PHP syntax check when doing :make
set makeprg=php\ -l\ %
" Parse PHP error output
set errorformat=%m\ in\ %f\ on\ line\ %l

" Exuberant Ctags
" Map <F4> to re-build tags file
nmap <silent> <F4>
    \ :!ctags -f ./tags
    \ --langmap="php:+.inc"
    \ -h ".php.inc" -R --totals=yes
    \ --tag-relative=yes --PHP-kinds=+cf-v .<CR>

" Set tag filename(s)
set tags=./tags,tags

