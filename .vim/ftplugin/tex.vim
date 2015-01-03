
" spell check
setlocal spell spelllang=en

" LaTeX coloration
let g:tex_flavor = "latex"

imap <C-E> <esc>yyPI\begin{<esc>A}<esc>tI\end{<esc>A}<esc>O
imap <C-F> <esc>O\[<esc>to\]<esc>sA
" AZERTY
"imap <C-E> <esc>yyPI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>O
"imap <C-F> <esc>O\[<esc>jo\]<esc>sA

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

