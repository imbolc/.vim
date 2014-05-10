" --- Setting up Vundle - the vim plugin bundler
    filetype off
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    filetype plugin indent on
    Bundle 'gmarik/vundle'


" --- Common
    set cm=blowfish         " Дефолтный режим шифрования
    set nocompatible
    set nowrap
    set novisualbell
    set t_vb=
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    set nobackup            " Не создавать резервные копии файлов
    set noswapfile
    syntax on
    set ttyfast
    set ruler               " Включение отображения позиции курсора (всё время)
    set history=500         " История команд
    set undolevels=500      " Максимальное количество изменений, которые могут быть отменены
    set statusline=%<%f%h%m%r%=(%{&fileencoding},%{&encoding})\ (%b,0x%B)\ %l,%c%V\ %P
    set laststatus=2
    set showcmd             " Включение отображения незавершенных команд в статусной строке
    set autoread            " Включение автоматического перечтения файла при изменении
    set nonumber
    "set autochdir           " Автоматически устанавливать текущей, директорию отрытого файла
    "set browsedir=buffer    " Начинать обзор с каталога текущего буфера
    "set confirm             " Включение диалогов с запросами
    
    " :tabe %%/ - will expand to the current file directory
    cabbr %% <C-R>=expand('%:p:h')<CR>

" --- Indent
    set smarttab      " в случае включения этой опции, нажатие Tab в начале строки (если быть точнее, до первого непробельного символа в строке) приведет к добавлению отступа, ширина которого соответствует shiftwidth (независимо от значений в tabstop и softtabstop). Нажатие на Backspace удалит отступ, а не только один символ, что очень полезно при включенной expandtab. Напомню: опция оказывает влияние только на отступы в начале строки, в остальных местах используются значения из tabstop и softtabstop.
    set tabstop=4     " количество пробелов, которыми символ табуляции отображается в тексте. Оказывает влияние как на уже существующие табуляции, так и на новые. В случае изменения значения, «на лету» применяется к тексту
    set softtabstop=4 " количество пробелов, которыми символ табуляции отображается при добавлении. Несмотря на то, что при нажатии на Tab вы получите ожидаемый результат (добавляется новый символ табуляции), фактически в отступе могут использоваться как табуляция так и пробелы. Например, при установленных tabstop равной 8 и softtabstop равной 4, троекратное нажатие Tab приведет к добавлению отступа шириной 12 пробелов, однако сформирован он будет из одного символа табуляции и 4 пробелов.
    set expandtab     " в режиме вставки заменяет символ табуляции на соответствующее количество пробелов. Так же влияет на отступы, добавляемые командами >> и <<
    set shiftwidth=4  " по умолчанию используется для регулирование ширины отступов в пробелах, добавляемых командами >> и <<. Если значение опции не равно tabstop, как и в случае с softtabstop, отступ может состоять как из символов табуляций так и из пробелов. При включении опции — smarttab, оказывает дополнительное влияние.
    set autoindent    " копирует отступы с текущей строки при добавлении новой
    
    au BufRead,BufNewFile *.ejs		setlocal filetype=html
    au BufRead,BufNewFile *.jade	setlocal filetype=html
    au BufRead,BufNewFile *.jinja2	setlocal filetype=htmljinja
    au BufRead,BufNewFile *.md  	setlocal filetype=markdown
    au BufRead,BufNewFile *.less  	setlocal filetype=less
    au BufRead,BufNewFile *.go  	setlocal filetype=go
    "au BufRead,BufNewFile *.csv  	setlocal filetype=csv

    " au FileType html       setlocal et sw=2 ts=2 sts=2 textwidth=0    " HTML (tab width 2 chr, no wrapping)
    " au FileType htmldjango setlocal et sw=2 ts=2 sts=2 textwidth=0
    au FileType python     setlocal et sw=4 ts=4 sts=4 " textwidth=79   " Python (tab width 4 chr, wrap at 79th char)
    au FileType markdown   setlocal et sw=4 ts=4 sts=4
    "au FileType css        setlocal et sw=2 ts=2 sts=2 " textwidth=79   " CSS (tab width 2 chr, wrap at 79th char)
    "au FileType less        setlocal et sw=2 ts=2 sts=2 " textwidth=79   " CSS (tab width 2 chr, wrap at 79th char)
    "au FileType javascript setlocal et sw=2 ts=2 sts=2 textwidth=79   " JavaScript (tab width 2 chr, wrap at 79th)
    au FileType coffee setlocal et sw=2 ts=2 sts=2 textwidth=79
    


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

    " подсвечиваем строки длиннее 80 символов
    au FileType python highlight OverLength ctermbg=darkblue ctermfg=white
    au FileType python match OverLength /\%80v.\+/

    " запуск скриптов
    au FileType python map <buffer> <F5> :w\|!python3 %<cr>
    " au FileType python map <buffer> <F5> :w\|!%:p<cr>

    " python syntax highlighting: http://www.vim.org/scripts/script.php?script_id=790 
    " Bundle 'vim-scripts/python.vim--Vasiliev'
    " Bundle 'hdima/python-syntax'
    Bundle 'mitsuhiko/vim-python-combined'
    " http://www.vim.org/scripts/script.php?script_id=1487
    Bundle 'vim-scripts/django.vim'
    " http://www.vim.org/scripts/script.php?script_id=2441
    "Bundle 'vim-scripts/pyflakes.vim'

" --- HTML
    " http://www.vim.org/scripts/script.php?script_id=2075
    "Bundle 'vim-scripts/indenthtml.vim'
    "Bundle 'othree/html5.vim'
    "Bundle 'Glench/Vim-Jinja2-Syntax'
    Bundle 'mitsuhiko/vim-jinja'


" --- JS
    " подсвечиваем строки длиннее 100 символов
    au FileType javascript highlight OverLength ctermbg=darkred ctermfg=white
    au FileType javascript match OverLength /\%100v.\+/

    " перед сохранением вырезаем пробелы на концах
    au BufWritePre *.js normal m`:%s/\s\+$//e ``
    " удалем пробелы на концах строк 
    au BufEnter *.js :call RemoveTrailingSpaces()

    " запуск скриптов
    au FileType javascript map <buffer> <F5> :w\|!node %<cr>
    
    " Bundle 'hallettj/jslint.vim'
    " http://www.vim.org/scripts/script.php?script_id=3081
    Bundle 'vim-scripts/JavaScript-Indent'

    " disable jsLint for json
    " au BufRead,BufNewFile *.json 	let g:JSLintHighlightErrorLine = 0

    " coffee script
    filetype off
    Bundle 'kchmck/vim-coffee-script'
    filetype on

" --- GO
    Bundle 'jnwhiteh/vim-golang'

    filetype off
    filetype plugin indent off
    set runtimepath+=$GOROOT/misc/vim
    filetype plugin indent on
    syntax on

    " autoformat .go files before saving
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt

    " runing by F5
    au FileType go map <buffer> <F5> :w\|!go run %<cr>

" --- Plugins
    "Syntax checking, needs:
    "python: flake8, pyflakes or pylint
    "js: sudo npm install -g jshint
    Bundle 'scrooloose/syntastic'
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_flake8_exe = "python3 -m flake8.run"

    " Bundle 'vim-scripts/AutoClose'

    " sudo aptitude install exuberant-ctags
    " Bundle 'majutsushi/tagbar'
    " autocmd BufEnter * nested :call tagbar#autoopen(0)

    Bundle 'sjl/gundo.vim.git'
    nnoremap <F8> :GundoToggle<CR>

    "Bundle 'noah/vim256-color'
    Bundle 'vim-scripts/wombat256.vim'
    set t_Co=256

    " snipmate
    " snippets repo: https://github.com/honza/vim-snippets
    "Bundle 'vim-addon-mw-utils'
    "Bundle 'tomtom/tlib_vim'
    "Bundle 'garbas/vim-snipmate'
    "let snippets_dir = '~/.vim/snippets'

    "Bundle 'ervandew/supertab'
    Bundle 'scrooloose/nerdcommenter'
    autocmd FileType htmljinja let &l:commentstring='{# %s #}'
    let NERDSpaceDelims=1

    Bundle 'scrooloose/nerdtree'

    " коммандный режим в русской раскладке
    Bundle 'powerman/vim-plugin-ruscmd'

    Bundle 'godlygeek/tabular'

    "Bundle 'chrisbra/csv.vim'

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
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

" Force Saving Files that Require Root Permission
    cmap w!! %!sudo tee > /dev/null %

" Auto install bundles first starting time
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif

" Spell checking
    setlocal spell spelllang=
    setlocal nospell
    function ChangeSpellLang()
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
    Bundle 'Shougo/neocomplcache.vim'

    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


color wombat256mod
