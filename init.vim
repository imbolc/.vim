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
      augroup END
    endif

" === Fix neovim + konsole
set guicursor=

call plug#begin()
"Plug 'editorconfig/editorconfig-vim'
Plug 'sgur/vim-editorconfig'

" === html
autocmd BufNewFile,BufReadPost *.svelte setlocal filetype=html  textwidth=80
Plug 'othree/html5.vim'

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

Plug 'ambv/black'
" autocmd BufWritePre *.py execute ':Black'

" === JavaScript
au FileType javascript map <buffer> <F5> :w\|!node --harmony %<cr>
Plug 'pangloss/vim-javascript'
" npm install -g js-beautify
Plug 'Chiel92/vim-autoformat'

" === JSX
" npm install -g eslint babel-eslint eslint-plugin-react
" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 0

" python: flake8, pyflakes or pylint
" js: sudo npm install -g eslint babel-eslint
Plug 'w0rp/ale'
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
"let g:ale_use_deprecated_neovim = 1
let g:ale_python_flake8_executable = expand('~/.vim/py3env/bin/flake8')
" let g:ale_lint_on_text_changed = 'never'
map <leader>e <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" === Markdown
" reformat: gq
autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown  textwidth=80
Plug 'plasticboy/vim-markdown'
let g:markdown_fenced_languages = ['python', 'js']
" autocmd FileType markdown setlocal colorcolumn=80

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
Plug 'vim-scripts/wombat256.vim'
" Plug 'robertmeta/nofrils'
" Plug 'noah/vim256-color'
Plug 'NLKNguyen/papercolor-theme'

" use f8 / shift+f8 to switch schemes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
" === Comments
Plug 'tomtom/tcomment_vim'
" Plug 'scrooloose/nerdcommenter'
" autocmd FileType jinja let &l:commentstring='{# %s #}'
" let NERDSpaceDelims = 1
" let g:NERDDefaultAlign = 'left'
" let g:NERDCommentEmptyLines = 1
" let g:NERDAltDelims_python = 1
"
" let g:ft = ''
" fu! NERDCommenter_before()
"     if &ft == 'vue'
"         let g:ft = 'vue'
"         let stack = synstack(line('.'), col('.'))
"         if len(stack) > 0
"             let syn = synIDattr((stack)[0], 'name')
"             if len(syn) > 0
"                 let syn = tolower(syn)
"                 exe 'setf '.syn
"             endif
"         endif
"     endif
" endfu
" fu! NERDCommenter_after()
"     if g:ft == 'vue'
"         setf vue
"         let g:ft = ''
"     endif
" endfu

" === Russian commands
Plug 'powerman/vim-plugin-ruscmd'

" === Autocompletion

"" pip3 install neovim
"" test `:echo has("python3")`
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1
""" pip3 install jedi
"Plug 'zchee/deoplete-jedi'
"Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }


" pip3 install neovim jedi mistune psutil setproctitle

Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}

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

map <leader>n :tabe ~/Yandex.Disk/Documents/notes.md<cr>

"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-notes'
"

Plug 'cespare/vim-toml'

Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
let g:rustfmt_autosave = 1
au FileType rust map <buffer> <F5> :w\|!rustc --edition=2018 % -o /tmp/vim.rs && /tmp/vim.rs && rm /tmp/vim.rs<cr>

Plug 'timonv/vim-cargo'
autocmd BufNewFile,BufReadPost main.rs setlocal filetype=cargo  textwidth=80
au FileType cargo map <buffer> <F5> :CargoRun<cr>

" Git branch in status line
Plug 'tpope/vim-fugitive'

" Tables
" `:TableModeToggle` to enter in table mode
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'  " markdown-compatible corners

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
" Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }
" au FileType go map <buffer> <F5> :w\|!go run %<cr>

Plug 'elmcast/elm-vim'

Plug 'tpope/vim-dadbod'

call plug#end()

" color wombat256mod
" highlight ColorColumn ctermbg=black guibg=black

" color 256_automation
highlight ColorColumn ctermbg=white
set background=light
try
    colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
    " pass
endtry


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
