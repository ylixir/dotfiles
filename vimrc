filetype off
filetype plugin on

set shell=/bin/sh
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
setlocal spell spelllang=en

syntax enable
set number
set term=st-256color
set cursorline
"set background=dark
"colorscheme solarized
"colorscheme inkpot
"colorscheme zenburn
"colorscheme molokai

imap <C-l> <right>
imap ^<TAB> ^{}<ESC>i
imap _<TAB> _{}<ESC>i
imap align<TAB> \begin{align*}<ESC>o\end{align*}<ESC>O<TAB>
imap tab<TAB> \begin{tabular}{}<ESC>o\end{tabular}<ESC>k4li
imap aligned<TAB> \begin{aligned}<ESC>o\end{aligned}<ESC>O<TAB>
imap array<TAB> \begin{array}{}\end{array}<ESC>11hi
imap /<TAB> \frac{}{}<ESC>2hi
imap (<TAB> \left(\right)<ESC>6hi
imap \|<TAB> \left\lvert\right\rvert<ESC>11hi
imap [<TAB> \left[\right]<ESC>6hi
imap <<TAB> \langle\rangle<ESC>6hi
imap int<TAB> \int{}<ESC>hi
imap sct1<TAB> \section*{}<ESC>i
imap sct2<TAB> \subsection*{}<ESC>i
imap sct3<TAB> \subsubsection*{}<ESC>i
imap N<TAB> \mathbb{N}
imap Z<TAB> \mathbb{Z}
imap Q<TAB> \mathbb{Q}
imap R<TAB> \mathbb{R}
imap C<TAB> \mathbb{C}
imap lplc<TAB> \mathscr{L}\{\}<ESC>hi
imap bar<TAB> \overline{}<ESC>i
imap bold<TAB> \boldsymbol{}<ESC>i
imap vec<TAB> \vec{}<ESC>i
imap pd<TAB> \partial 
imap dydx<TAB> \frac{\mathrm{d}y}{\mathrm{d}x}
imap dydt<TAB> \frac{\mathrm{d}y}{\mathrm{d}t}
imap dxdt<TAB> \frac{\mathrm{d}x}{\mathrm{d}t}
imap dy<TAB> \mathrm{d}y
imap dt<TAB> \mathrm{d}t
imap dv<TAB> \mathrm{d}v
imap dx<TAB> \mathrm{d}x
imap sum<TAB> \sum\limits{}<ESC>hi
imap set<TAB> \{\}<ESC>hi
imap ncr<TAB> \binom{}{}<ESC>2hi
imap mt<TAB> $$<ESC>i
imap MT<TAB> $\displaystyle $<ESC>i
imap mtl<TAB> <ESC>o\[\]<ESC>o<ESC>k02li
imap enum<TAB> \begin{enumerate}<ESC>o\end{enumerate}<ESC>O\item<ESC>o
imap itemize<TAB> \begin{itemize}<ESC>o\end{itemize}<ESC>O\item<ESC>o
imap txt<TAB> \text{}<ESC>i
imap itxt<TAB> \intertext{}<ESC>i
imap cases<TAB> \begin{cases}\end{cases}<ESC>10hi
imap root<TAB> \sqrt{}<ESC>i
imap ga<TAB> \alpha
imap gA<TAB> \Alpha
imap gb<TAB> \beta
imap gB<TAB> \Beta
imap gp<TAB> \pi
imap gP<TAB> \Pi
imap gd<TAB> \delta
imap gD<TAB> \Delta
imap ge<TAB> \epsilon
imap gE<TAB> \varepsilon
imap go<TAB> \omega
imap gO<TAB> \Omega
imap gm<TAB> \mu
imap gM<TAB> \Mu
imap gf<TAB> \phi
imap gF<TAB> \varphi
imap gg<TAB> \gamma
imap gG<TAB> \Gamma
imap gl<TAB> \lambda
imap gL<TAB> \Lambda
imap gz<TAB> \xi
imap gZ<TAB> \Xi
imap gt<TAB> \theta
imap gT<TAB> \Theta
