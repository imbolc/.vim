" --- Common
    set nocompatible
    let mapleader=","
    set cm=blowfish         " defautl encryption mode

    set nobackup            " do not create backups
    set noswapfile
    set nowritebackup

    set nowrap
    set novisualbell
    set t_vb=
    set backspace=indent,eol,start whichwrap+=<,>,[,]

    syntax on
    set ttyfast
    set ruler               " show the cursor position all the time
    set history=50          " history of commands
    set undolevels=500      " history of undos

    set statusline=%<%f%h%m%r%=(%{&fileencoding},%{&encoding})\ (%b,0x%B)\ %l,%c%V\ %P
    set laststatus=2

    set showcmd             " display incomplete commands
    set autoread            " automatically re-read changed files, works only in GUI
    set autowrite           " automatically :write before running commands
    set nonumber
    set foldmethod=syntax
    set foldlevelstart=200  " open all folds when opening a file
    
    " :tabe %%/ - will expand to the current file directory
    cabbr %% <C-R>=expand('%:p:h')<CR>

    " auto-reload vimrc
    augroup reload_vimrc " {
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END " }

    "enable mouse support
    "set mouse=a

" --- Indent
    set smarttab      " в случае включения этой опции, нажатие Tab в начале строки (если быть точнее, до первого непробельного символа в строке) приведет к добавлению отступа, ширина которого соответствует shiftwidth (независимо от значений в tabstop и softtabstop). Нажатие на Backspace удалит отступ, а не только один символ, что очень полезно при включенной expandtab. Напомню: опция оказывает влияние только на отступы в начале строки, в остальных местах используются значения из tabstop и softtabstop.
    set tabstop=4     " количество пробелов, которыми символ табуляции отображается в тексте. Оказывает влияние как на уже существующие табуляции, так и на новые. В случае изменения значения, «на лету» применяется к тексту
    set softtabstop=4 " количество пробелов, которыми символ табуляции отображается при добавлении. Несмотря на то, что при нажатии на Tab вы получите ожидаемый результат (добавляется новый символ табуляции), фактически в отступе могут использоваться как табуляция так и пробелы. Например, при установленных tabstop равной 8 и softtabstop равной 4, троекратное нажатие Tab приведет к добавлению отступа шириной 12 пробелов, однако сформирован он будет из одного символа табуляции и 4 пробелов.
    set expandtab     " в режиме вставки заменяет символ табуляции на соответствующее количество пробелов. Так же влияет на отступы, добавляемые командами >> и <<
    set shiftwidth=4  " по умолчанию используется для регулирование ширины отступов в пробелах, добавляемых командами >> и <<. Если значение опции не равно tabstop, как и в случае с softtabstop, отступ может состоять как из символов табуляций так и из пробелов. При включении опции — smarttab, оказывает дополнительное влияние.
    set autoindent    " копирует отступы с текущей строки при добавлении новой
    
    au BufRead,BufNewFile *.ejs		setlocal filetype=html
    au BufRead,BufNewFile *.tag		setlocal filetype=html
    au BufRead,BufNewFile *.html	setlocal filetype=jinja
    au BufNewFile,BufReadPost *.md  setlocal filetype=markdown
    au BufRead,BufNewFile *.less  	setlocal filetype=less
    au BufRead,BufNewFile *.go  	setlocal filetype=go
    au BufRead,BufNewFile *.rs  	setlocal filetype=rust
    "au BufRead,BufNewFile *.csv  	setlocal filetype=csv

    au FileType html       setlocal et sw=2 ts=2 sts=2 textwidth=0    " HTML (tab width 2 chr, no wrapping)
    " au FileType htmldjango setlocal et sw=2 ts=2 sts=2 textwidth=0
    au FileType python     setlocal et sw=4 ts=4 sts=4 " textwidth=79   " Python (tab width 4 chr, wrap at 79th char)
    au FileType markdown   setlocal et sw=4 ts=4 sts=4 textwidth=79
    au FileType yaml       setlocal et sw=4 ts=4 sts=4
    "au FileType css        setlocal et sw=2 ts=2 sts=2 " textwidth=79   " CSS (tab width 2 chr, wrap at 79th char)
    "au FileType less        setlocal et sw=2 ts=2 sts=2 " textwidth=79   " CSS (tab width 2 chr, wrap at 79th char)
    au FileType javascript setlocal et sw=2 ts=2 sts=2 textwidth=79   " JavaScript (tab width 2 chr, wrap at 79th)
    


" --- Encoding
    set encoding=utf-8      " Кодировка по умолчанию
    set fileencoding=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866,ucs-bom,ascii
    set fileformat=unix     " Формат файла по умолчанию
    set fileformats=unix,dos,mac

" --- Search
    set ignorecase 		" Игнорировать регист при поиске
    set smartcase 		" Учитывать регистр при поиске если в строке есть заглавные символы
    set incsearch		" Поиск во время набора
    set showmatch
    set hlsearch
    set gdefault        " %s/foo/bar/ вместо %s/foo/bar/g


" --- Python
    let python_highlight_all = 1
    " перед сохранением вырезаем пробелы на концах
    au BufWritePre *.py normal m`:%s/\s\+$//e ``
    " удалем пробелы на концах строк 
    "au BufEnter *.py :call RemoveTrailingSpaces()

    " запуск скриптов
    au FileType python map <buffer> <F5> :w\|!python %<cr>
    " au FileType python map <buffer> <F5> :w\|!%:p<cr>

    call plug#begin()

    Plug 'mitsuhiko/vim-python-combined'
    " Plug 'vim-scripts/django.vim'
    " Plug 'hynek/vim-python-pep8-indent'

    " Plug 'tmhedberg/SimpylFold'

" --- HTML
    " Plug 'mitsuhiko/vim-jinja'
    " Plug 'Glench/Vim-Jinja2-Syntax'
    " Plug 'othree/html5.vim'
    Plug 'lepture/vim-jinja'
    " Plug 'alvan/vim-closetag'
    " let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.js"


" --- Less
    " Plug 'groenewege/vim-less'

" --- JS
    " подсвечиваем строки длиннее 100 символов
    " au FileType javascript highlight OverLength ctermbg=darkred ctermfg=white
    " au FileType javascript match OverLength /\%100v.\+/

    " перед сохранением вырезаем пробелы на концах
    " au BufWritePre *.js normal m`:%s/\s\+$//e ``
    " удалем пробелы на концах строк 
    " au BufEnter *.js :call RemoveTrailingSpaces()

    " запуск скриптов
    au FileType javascript map <buffer> <F5> :w\|!node --harmony %<cr>
    
    " Plug 'hallettj/jslint.vim'
    Plug 'pangloss/vim-javascript'
    " let b:javascript_fold=0

    " disable jsLint for json
    " au BufRead,BufNewFile *.json 	let g:JSLintHighlightErrorLine = 0

    " npm install -g js-beautify
    Plug 'Chiel92/vim-autoformat'

" --- Plugins
    "Syntax checking, needs:
    "python: flake8, pyflakes or pylint
    "js: sudo npm install -g jshint
    " Plug 'scrooloose/syntastic'
    " let g:syntastic_check_on_open=1
    " let g:syntastic_python_checkers=['flake8']
    " let g:syntastic_javascript_checkers = ['eslint']

" --- Vue
    Plug 'posva/vim-vue'

" === Linters
" python: flake8, pyflakes or pylint
" js: sudo npm install -g eslint babel-eslint
Plug 'w0rp/ale'
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_python_flake8_executable = expand('~/.vim/py3env/bin/flake8')
" let g:ale_lint_on_text_changed = 'never'
map <leader>e <Plug>(ale_next_wrap)<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" python: flake8, pyflakes or pylint
" js: sudo npm install -g jshint
"Plug 'neomake/neomake'
"autocmd! BufWritePost,BufEnter * Neomake
"let g:neomake_warning_sign = {
"  \ 'text': 'W',
"  \ 'texthl': 'WarningMsg',
"  \ }
"let g:neomake_error_sign = {
"  \ 'text': 'E',
"  \ 'texthl': 'ErrorMsg',
"  \ }

    " Plug 'vim-scripts/AutoClose'

    " sudo aptitude install exuberant-ctags
    " Plug 'majutsushi/tagbar'
    " autocmd BufEnter * nested :call tagbar#autoopen(0)


    "Plug 'noah/vim256-color'
    Plug 'vim-scripts/wombat256.vim'
    "Plug 'robertmeta/nofrils'
    Plug 'NLKNguyen/papercolor-theme'
    set t_Co=256

    Plug 'scrooloose/nerdcommenter'
    autocmd FileType jinja let &l:commentstring='{# %s #}'
    let NERDSpaceDelims=1
    let g:NERDDefaultAlign = 'left'

    " Plug 'scrooloose/nerdtree'

    " коммандный режим в русской раскладке
    Plug 'powerman/vim-plugin-ruscmd'

    Plug 'godlygeek/tabular'

    " Plug 'kien/ctrlp.vim'
    " let g:ctrlp_map = '<c-p>'
    " let g:ctrlp_cmd = 'CtrlP'
    
    Plug 'editorconfig/editorconfig-vim'

imap <F5> <Esc><F5>


""" Вкл/Выкл вставку as-is: <F4>
""" в NORMAL: i и <Insert> всегда входят в INSERT с nopaste
""" в NORMAL: <F4> входит в INSERT с paste
""" в INSERT: <F4> переключает paste/nopaste
    nnoremap <F4>       :set paste<CR>i
    nnoremap i          :set nopaste<CR>i
    nnoremap <Insert>   :set nopaste<CR><Insert>
    imap <F4> <C-O>:set paste<CR>
    set pastetoggle=<xF4>

" Удалить пробелы в конце строк
    function! RemoveTrailingSpaces()
       normal! mzHmy
       execute '%s:\s\+$::ge'
       normal! 'yzt`z
    endfunction

" Reselect visual block after indent/outdent  
    vnoremap < <gv
    vnoremap > >gv

" Easy split navigation
    nnoremap <C-h> <C-w>h
    " nnoremap <C-j> <C-w>j
    " nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

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

" Autocompletion
    Plug 'Shougo/neocomplcache.vim'
    let g:neocomplcache_enable_at_startup = 1

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,jinja setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Plug 'szw/vim-ctrlspace'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-fugitive'
Plug 'ingydotnet/yaml-vim'
Plug 'dyng/ctrlsf.vim'

" rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
au FileType rust map <buffer> <F5> :w\|RustRun<cr>


" Ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
let g:ranger_map_keys = 0
let g:ranger_open_new_tab = 1
map <leader>r :Ranger<CR>

call plug#end()
" color wombat256mod

color wombat256mod
