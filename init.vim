" === Common
set nocompatible
let mapleader=","

set nobackup            " do not create backups
set noswapfile
set nowritebackup

set splitright
set splitbelow

set nowrap
set novisualbell
set t_vb=
set backspace=indent,eol,start whichwrap+=<,>,[,]

syntax on
set ttyfast
set ruler               " show the cursor position all the time
set history=50          " history of commands
set undolevels=500      " history of undos
set title               " change the terminal's title

set statusline=%<%f%h%m%r%=%{fugitive#statusline()}\ (%{&fileencoding},%{&encoding})\ (%b,0x%B)\ %l,%c%V\ %P
set laststatus=2

"set cursorline          " Highlight current line 
set showcmd             " display incomplete commands
set autoread            " automatically re-read changed files, works only in GUI
set autowrite           " automatically :write before running commands
set nonumber
set foldmethod=syntax
set foldlevelstart=200  " open all folds when opening a file
set mouse=
set completeopt=menu    " do not show help window for std python library
imap <F5> <Esc><F5>
filetype plugin indent on

" show trailing whitespace chars
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
highlight SpecialKey ctermfg=grey guifg=grey70

" === Indent
    set smarttab
    set tabstop=4
    set softtabstop=4
    set expandtab
    set shiftwidth=4
    set autoindent

" === Search
    set ignorecase
    set smartcase
    set incsearch
    set showmatch
    set hlsearch
    set gdefault

" === Encoding
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866,ucs-bom,ascii
    set fileformat=unix
    set fileformats=unix,dos,mac

" === Templates
    if has("autocmd")
      augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.vue 0r ~/.vim/templates/skeleton.vue
        autocmd BufNewFile *.svelte 0r ~/.vim/templates/skeleton.svelte
      augroup END
    endif

" === Fix neovim + konsole
set guicursor=

command! -nargs=1 ChangeExt execute "saveas ".expand("%:p:r").<q-args>

call plug#begin()

"Plug 'editorconfig/editorconfig-vim'
Plug 'sgur/vim-editorconfig'

" === html
" autocmd BufNewFile,BufReadPost *.svelte setlocal filetype=html
" Plug 'othree/html5.vim'

" === svelte
Plug 'evanleck/vim-svelte'

" === C
au FileType c map <buffer> <F5> :w\|!gcc % -o /tmp/% && /tmp/%<cr>

" === Python
autocmd FileType python setlocal colorcolumn=80

let g:python3_host_prog = expand('~/.vim/py3env/bin/python')
let python_highlight_all = 1

" run python scripts
au FileType python map <buffer> <F5> :w\|!python %<cr>
" remove trailing slashes
" au BufWritePre *.py normal m`:%s/\s\+$//e ``
Plug 'mitsuhiko/vim-python-combined'
Plug 'lepture/vim-jinja'


" === JavaScript
au FileType javascript map <buffer> <F5> :w\|!node --harmony %<cr>
Plug 'pangloss/vim-javascript'
" npm install -g js-beautify
Plug 'Chiel92/vim-autoformat'

" === SQL
au FileType sql map <buffer> <F5> :w\|!psql -f %<cr>
Plug 'lifepillar/pgsql.vim'
let g:sql_type_default = 'pgsql'

" === JSX
" npm install -g eslint babel-eslint eslint-plugin-react
" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 0

" python: flake8, pyflakes or pylint
Plug 'w0rp/ale'
let g:ale_linters = {
\   'html': ['eslint'],
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'svelte': ['eslint'],
\}
let g:ale_fixers = {
\   'html': ['eslint'],
\   'javascript': ['eslint'],
\   'svelte': ['eslint'],
\   'python': ['black'],
\}
let g:ale_fix_on_save = 1
let g:ale_virtualenv_dir_names = ['var/env', '.env', '.venv', 'env', 'venv']
" let g:ale_python_black_options='--skip-string-normalization --line-length 80'
map <leader>e <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" === Markdown
" reformat: gq
autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown  textwidth=80
Plug 'plasticboy/vim-markdown'
let g:markdown_fenced_languages = ['python', 'js']
" autocmd FileType markdown setlocal colorcolumn=80
" npm install marked
au FileType markdown map <buffer> <F5> :w\|!marked % > /tmp/vim.md.html && xdg-open /tmp/vim.md.html<cr>

" === Vue
Plug 'posva/vim-vue'

" === Prettier
"Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': [
        \ 'javascript',
        \ 'json',
        \ 'css',
        \ 'markdown',
        \ 'vue',
        \ 'graphql'
    \ ] }
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'

" === Linters
" python: flake8, pyflakes or pylint
" js: sudo npm install -g jshint
" Plug 'neomake/neomake'
" autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_warning_sign = {
"   \ 'text': 'W',
"   \ 'texthl': 'WarningMsg',
"   \ }
" let g:neomake_error_sign = {
"   \ 'text': 'E',
"   \ 'texthl': 'ErrorMsg',
"   \ }
" let g:neomake_python_enabled_makers = ['flake8']
" let g:neomake_python_flake8_maker = {
"   \ 'exe': expand('~/.vim/py3env/bin/flake8')
"   \ }

" === Colors
set t_Co=256
set background=light
highlight ColorColumn ctermbg=white

" use f8 / shift+f8 to switch schemes
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-colorscheme-switcher'

Plug 'vim-scripts/wombat256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'


Plug 'junegunn/vim-slash'  " automatically remove search selection

Plug 'tomtom/tcomment_vim' " comments `gc` for block and `gcc` for a single line
if !exists('g:tcomment#filetype#map')
    let g:tcomment#filetype#map = {}
endif
let g:tcomment#filetype#map['svelte'] = 'html'

Plug 'powerman/vim-plugin-ruscmd'  " russian symbols in commands

Plug 'junegunn/fzf', { 'do': './install --all' }
map <leader>f :call fzf#run({'sink': 'tabedit'})<cr>

" === notes
let notes_path = '~/Documents/scroll/'
" sudo apt install riprgep
Plug 'junegunn/fzf.vim'
let g:fzf_action = {'return': 'vsplit'}
let $FZF_DEFAULT_COMMAND = 'ag -g ""' " honor .gitignore
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --no-heading --line-number --column --smart-case --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': notes_path}, 'right:50%'),
  \   <bang>0)
map <leader>n :Rg<cr>
map <leader>c :execute 'tabe' notes_path<cr>

" === Autocompletion

" pip3 install neovim mypy
" test `:echo has("python3")`
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"" pip3 install jedi
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }


" pip3 install neovim jedi mistune psutil setproctitle

"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}


" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
"
" " IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect
"
" " NOTE: you need to install completion sources to get completions. Check
" " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-racer'

Plug 'godlygeek/tabular'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <buffer> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


" Enable omni completion.
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Mizuchi/vim-ranger'
map <leader>r :w\|:tabe %:p:h<cr>

" map <leader>n :tabe ~/Yandex.Disk/Documents/notes.md<cr>

"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-notes'
"

Plug 'cespare/vim-toml'

Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
let g:rustfmt_autosave = 1
au FileType rust map <buffer> <F5> :w\|!rustc --edition=2018 % -o /tmp/vim.rs && /tmp/vim.rs && rm /tmp/vim.rs<cr>

Plug 'timonv/vim-cargo'
" autocmd BufNewFile,BufReadPost main.rs setlocal filetype=cargo  textwidth=80
au FileType cargo map <buffer> <F5> :CargoRun<cr>

" Git branch in status line
Plug 'tpope/vim-fugitive'

" Tables
" `:TableModeToggle` to enter in table mode
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'  " markdown-compatible corners

Plug 'ollykel/v-vim'
au FileType vlang map <buffer> <F5> :w\|!v run %<cr>

" CSV
Plug 'mechatroner/rainbow_csv'

" Auto paste mode
Plug 'ConradIrwin/vim-bracketed-paste'

" Nim
Plug 'zah/nim.vim'

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" Tmux splits integration
Plug 'christoomey/vim-tmux-navigator'

" Golang
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }
au FileType go map <buffer> <F5> :w\|!go run %<cr>

Plug 'tpope/vim-dadbod'

call plug#end()

" try
"     colorscheme PaperColor
" catch /^Vim\%((\a\+)\)\=:E185/
"     " pass
" endtry

" Reselect visual block after indent/outdent  
    vnoremap < <gv
    vnoremap > >gv

" Go to next error
    nnoremap ge :lnext<cr>

" Force Saving Files that Require Root Permission
    cmap w!! %!sudo tee > /dev/null %

" Spell checking
    setlocal spell spelllang=
    setlocal nospell
    function! ChangeSpellLang()
        if &spelllang == ""
            setlocal spell spelllang=ru,en
            echo "spelllang: ru,en"
        else
            setlocal spell spelllang=
            setlocal nospell
            echo "spelllang: off"
        endif
    endfunc
    " map spell on/off for English/Russian
    map <F9> <Esc>:call ChangeSpellLang()<CR>
