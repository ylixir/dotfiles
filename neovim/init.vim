" install package manager as required
function! PackInit() abort
  silent packadd minpac
  if !exists('*minpac#init')
    "exe '!mkdir -p ~/.config/nvim/pack/minpac/opt'
    exe '!git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac'
    packadd minpac
  endif
  call minpac#init()
    " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('ryanoasis/vim-devicons') "first according to docs

    call minpac#add('Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' })
    call minpac#add('Xuyuanp/nerdtree-git-plugin')
    call minpac#add('Yggdroot/indentLine')
    call minpac#add('atelierbram/Base2Tone-vim')
    call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': '!bash install.sh'})
    call minpac#add('ayu-theme/ayu-vim')
    call minpac#add('eraserhd/parinfer-rust', {'do':  '!cargo build --release'})
    call minpac#add('itchyny/lightline.vim')
    call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('liuchengxu/vim-which-key')
    call minpac#add('luochen1990/rainbow')
    call minpac#add('mengelbrecht/lightline-bufferline')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-eunuch')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('vim-vdebug/vdebug')
    call minpac#add('w0rp/ale')
    call minpac#add('yous/vim-open-color')
  call minpac#update()
endfunction

" this won't work in the terminal
silent call rpcnotify(1, 'Gui', 'Font', 'Monoid Nerd Font 14')
" the gi still sucks
silent call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
silent call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

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

set t_Co=256
set termguicolors
set colorcolumn=80
set cursorline
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
set noshowmode
let g:indentLine_enabled = 1
let g:indent_guides_enable_on_vim_startup = 1
"colorscheme inkpot
"colorscheme open-color
"colorscheme ayu
colorscheme Base2Tone_EveningDark

"deoplete (autocompletion)
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

set mouse=a
set ignorecase
set smartcase
let mapleader=" "

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
set nofoldenable
let php_folding=1
set foldmethod=syntax
set splitright
set splitbelow

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
inoremap ;; <C-o>m`<C-o>A;<C-o>``
inoremap ,, <C-o>m`<C-o>A,<C-o>``
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"c-_ is the same as c-/
tnoremap <c-_> <c-\><c-n>
nnoremap <c-a> <c-o>
nnoremap <c-o> :vs<cr>
nnoremap <c-u> :sp<cr>
nnoremap <c-t> :te<cr>

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

"rainbow parens
let g:rainbow_active = 1

"set up language servers
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
"intelephense is faster, better feature support
let g:LanguageClient_serverCommands = {
  \ 'php' : ['npx', '--quiet', 'intelephense', '--stdio'],
  \ }
"psalm is better at finding errors but LanguageClient can only rock one lang server now
"https://github.com/autozimu/LanguageClient-neovim/issues/473
let g:ale_linters = { 'php': ['php', 'psalm'] }

autocmd BufRead,BufNewFile *.jsonnet set filetype=jsonnet
autocmd FileType jsonnet :packadd vim-jsonnet

autocmd TermOpen term://* startinsert
