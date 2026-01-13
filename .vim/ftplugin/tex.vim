" autocompile upon save
autocmd BufWritePost * !tectonic %

" spell check
setlocal spell spelllang=en

" LaTeX coloration
let g:tex_flavor = "latex"

imap <C-E> <esc>yyPI\begin{<esc>A}<esc>tI\end{<esc>A}<esc>O
imap <C-F> <esc>O\[<esc>to\]<esc>sA

imap ,p \part{}<LEFT>
imap ,s \section{}<LEFT>
imap ,ss \subsection{}<LEFT>
imap ,sss \subsubsection{}<LEFT>
imap ,pp \paragraph{}<LEFT>
imap ,spp \subparagraph{}<LEFT>

imap ,p- \part*{}<LEFT>
imap ,s- \section*{}<LEFT>
imap ,ss- \subsection*{}<LEFT>
imap ,sss- \subsubsection*{}<LEFT>
imap ,pp- \paragraph*{}<LEFT>
imap ,spp- \subparagraph*{}<LEFT>

imap ,em \emph{}<LEFT>
imap ,$ $$<LEFT>

imap ,ite \begin{itemize}<CR>\end{itemize}<ESC>O\item<SPACE>
imap ,it \item<SPACE>

imap ,o <ESC>o
imap ,O <ESC>O

set nocursorline
set textwidth=0
set wrapmargin=0


setlocal foldmethod=expr
setlocal foldexpr=TeXFold(v:lnum)

function! TeXFold(lnum)
    let line = getline(a:lnum)
    let default_envs = g:tex_fold_use_default_envs?
        \['frame', 'table', 'figure', 'align', 'lstlisting']: []
    let envs = '\(' . join(default_envs + g:tex_fold_additional_envs, '\|') . '\)'

    if line =~ '^\s*\\section'
        return '>1'
    endif

    if line =~ '^\s*\\subsection'
        return '>2'
    endif

    if line =~ '^\s*\\subsubsection'
        return '>3'
    endif

    if !g:tex_fold_ignore_envs
        if line =~ '^\s*\\begin{' . envs
            return 'a1'
        endif

        if line =~ '^\s*\\end{' . envs
            return 's1'
        endif
    endif

    if g:tex_fold_allow_marker
        if line =~ '^[^%]*%[^{]*{{{'
            return 'a1'
        endif

        if line =~ '^[^%]*%[^}]*}}}'
            return 's1'
        endif
    endif

    return '='
endfunction
