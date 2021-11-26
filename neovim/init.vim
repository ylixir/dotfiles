" install package manager as required
function! PackInit() abort
  silent packadd minpac
  if !exists('*minpac#init')
    "exe '!mkdir -p ~/.config/nvim/pack/minpac/opt'
    exe '!git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac'
    packadd minpac
  endif
  call minpac#init()
    call minpac#add('Xuyuanp/nerdtree-git-plugin')
    call minpac#add('Yggdroot/indentLine')
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('atelierbram/Base2Tone-vim')
    call minpac#add('direnv/direnv.vim')
    call minpac#add('eraserhd/parinfer-rust', {'do':  '!nix-shell --run "cargo build --release"'})
    call minpac#add('itchyny/lightline.vim')
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim', {'rev':'23dda8602f138a9d75dd03803a79733ee783e356'})
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('liuchengxu/vim-which-key')
    call minpac#add('liuchengxu/vista.vim')
    call minpac#add('luochen1990/rainbow')
    call minpac#add('mhinz/vim-startify')
    call minpac#add('mildred/vim-bufmru')
    call minpac#add('moll/vim-bbye')
    call minpac#add('morhetz/gruvbox')
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    call minpac#add('rhysd/vim-clang-format')
    call minpac#add('ryanoasis/vim-devicons', {'name': 'z-vim-devicons'}) "last according to docs
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('sainnhe/archived-colors')
    call minpac#add('sheerun/vim-polyglot')
    "call minpac#add('tmsvg/pear-tree')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-eunuch')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-vividchalk')
    call minpac#add('wadackel/vim-dogrun')
    call minpac#add('vim-vdebug/vdebug')
  call minpac#update()
  CocInstall coc-rust-analyzer
  CocInstall coc-angular
  CocInstall coc-eslint
  CocInstall coc-json
  CocInstall coc-solargraph
  CocInstall coc-tslint-plugin
  CocInstall coc-tsserver
  CocInstall coc-vetur
endfunction

" this won't work in the terminal
silent! call rpcnotify(1, 'Gui', 'Font', 'JuliaMono:h10')
silent! VVset fontfamily='Hack'
silent! VVset fontsize=10
" the gui still sucks
silent! call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
silent! call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PlugUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PlugClean  call PackInit() | call minpac#clean()
command! PlugStatus call PackInit() | call minpac#status()

"make sure terminal can pop a fish shell
let $FISHLVL=''
set path+=./src

"relative line numbers
set number
set signcolumn=yes
set list
set listchars=tab:├─
"toggle to absolute line numbers unless we are in normal focus
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

"hack from reddit to keep terminal windows in the buffer list
augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal number bufhidden=hide
augroup END

set t_Co=256 "fzf needs this?
set termguicolors
set colorcolumn=80
set cursorline
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
set noshowmode
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['markdown','startify','nerdtree']
let g:indent_guides_enable_on_vim_startup = 1

"colorscheme Base2Tone_EveningDark
"colorscheme dogrun
"colorscheme vividchalk
set background=light
colorscheme fairy-garden

"needed for colorscheme override
filetype plugin indent on
syntax on

hi ColorColumn guibg=#f9c19b
hi VertSplit guibg=#f9c19b

"deoplete (autocompletion)
"let g:deoplete#enable_at_startup = 1

"not works for deoplete and coc at least
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set mouse=a
set ignorecase
set smartcase
let mapleader=" "

let g:vista_fzf_preview = ['right:50%']
let g:vista_default_executive = 'coc'
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
set foldcolumn=1
set splitright
set splitbelow

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

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
nnoremap <c-t> :te<cr>i

nnoremap <silent> <expr> <leader>t g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

nnoremap <silent> <leader>q :Bdelete<CR>
nnoremap <silent> <leader>v :Vista!!<cr>

" fzf config
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  let height = float2nr(&lines * 0.6)
  let width = float2nr(&columns * 0.9)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nmap <leader>F :Files<CR>
nmap <leader>a :Rag<Space>
nmap <leader>b :Buffers<CR>
nmap <leader>f :GFiles<CR>

" nnoremap <leader>w :silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote --no-semi<CR>
let g:vdebug_keymap = {
\    "run" : "<leader>/",
\    "run_to_cursor" : "<Up>",
\    "step_over" : "<Down>",
\    "step_into" : "<Right>",
\    "step_out" : "<Left>",
\    "close" : "q",
\    "detach" : "x",
\    "set_breakpoint" : "<leader>p",
\    "eval_visual" : "<leader>e"
\}
nnoremap <esc> :noh<return><esc>

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set showtabline=2
let g:lightline#bufferline#show_number=1
let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'method' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ] },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ] ] },
  \ 'tabline': {
  \   'left': [ [ 'mrubuffers' ] ],
  \   'right': [ [ 'bufferclose','tabnum' ] ] },
  \
  \ 'component_expand': {
  \   'mrubuffers': 'bufmru#lightline#buffers',
  \   'bufferclose': 'bufmru#lightline#close',
  \   'tabnum': 'bufmru#lightline#tabnum' },
  \ 'component_function': {
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \   'gitbranch': 'fugitive#head',
  \   'method': 'NearestMethodOrFunction',
  \   },
  \ 'component_raw': {
  \   'mrubuffers':     1,
  \   'bufferclose':    1,
  \   'tabnum': 1,
  \   },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \   'mrubuffers': 'tabsel',
  \   },
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"rainbow parens
let g:rainbow_active = 1

"set up language servers
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
"intelephense is faster, better feature support
"let g:LanguageClient_serverCommands = {
"  \ 'php' : ['intelephense', '--stdio'],
"  \ 'javascript': ['javascript-typescript-stdio'],
"  \ 'typescript': ['javascript-typescript-stdio'],
"  \ }
"psalm is better at finding errors but LanguageClient can only rock one lang server now
"https://github.com/autozimu/LanguageClient-neovim/issues/473
"let g:ale_linters_explicit = 1
"let g:ale_linters = { 'php': ['php', 'psalm'] }

nnoremap <silent> K :call CocActionAsync('doHover')<cr>
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<cr>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<cr>
nnoremap <leader>w :call CocActionAsync('doQuickfix')<cr>

autocmd BufRead,BufNewFile *.jsonnet set filetype=jsonnet
autocmd FileType jsonnet :packadd vim-jsonnet
autocmd FileType c,cpp ClangFormatAutoEnable

