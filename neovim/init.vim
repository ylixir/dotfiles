"make sure terminal can pop a fish shell
let $FISHLVL=''

"relative line numbers
set number relativenumber
"toggle to absolute line numbers unless we are in normal focus
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"hack from reddit to keep terminal windows in the buffer list
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-eunuch'
    Plug 'luochen1990/rainbow'
    Plug 'Yggdroot/indentLine'
    Plug 'autozimu/LanguageClient-neovim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'eraserhd/parinfer-rust', {'do':  'cargo build --release'}
"    vdebug
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
"    vim-devicons
"    vim-nix
    Plug 'sheerun/vim-polyglot'
"    vim-slime
"    vimspector
"    vista
call plug#end()
" PlugUpdate

set t_Co=256
set termguicolors
set colorcolumn=80
set cursorline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'
let g:indent_guides_enable_on_vim_startup = 1
colorscheme inkpot

set mouse=a
set smartcase
let mapleader=" "

let g:indentLine_enabled = 1
" Indenting defaults (does not override vim-sleuth's indenting detection)
" Defaults to 4 spaces for most filetypes
if get(g:, '_has_set_default_indent_settings', 0) == 0
    " Set the indenting level to 2 spaces for the following file types.
    autocmd FileType typescript,javascript,jsx,tsx,css,html,ruby,elixir,kotlin,vim,plantuml
        \ setlocal expandtab tabstop=2 shiftwidth=2
    set expandtab
    set tabstop=4
    set shiftwidth=4
    let g:_has_set_default_indent_settings = 1
endif
set autoindent

nnoremap <silent> <leader>q :lclose<bar>bn<bar>bd #<CR>
nnoremap <silent> <leader>t :NERDTreeFind<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>a :Ag<Space>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :GFiles<CR>
let g:vdebug_keymap = {
\    "run" : "<Leader>/",
\    "run_to_cursor" : "<Up>",
\    "step_over" : "<Down>",
\    "step_into" : "<Right>",
\    "step_out" : "<Left>",
\    "close" : "q",
\    "detach" : "x",
\    "set_breakpoint" : "<Leader>p",
\    "eval_visual" : "<Leader>e"
\}
nnoremap <esc> :noh<return><esc>

let g:rainbow_active = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"set up language servers
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
"intelephense is faster, better feature support
let g:LanguageClient_serverCommands = {
    \ 'php' : ['intelephense', '--stdio'],
    \ }
"psalm is better at finding errors but we can only rock one lang server now
"https://github.com/autozimu/LanguageClient-neovim/issues/473
"    \ 'php' : ['php', './vendor/bin/psalm-language-server'],

"deoplete (autocompletion)
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"vista (display symbol tree)
let g:vista_default_executive = 'lcn'

"slime
let g:slime_target = "neovim"

autocmd BufRead,BufNewFile *.elm set filetype=elm
autocmd FileType elm :packadd elm-vim

autocmd BufRead,BufNewFile *.jsonnet set filetype=jsonnet
autocmd FileType jsonnet :packadd vim-jsonnet