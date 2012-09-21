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
    set nocompatible
    set nowrap
    set novisualbell
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
    set number
    "set autochdir           " Автоматически устанавливать текущей, директорию отрытого файла
    "set browsedir=buffer    " Начинать обзор с каталога текущего буфера
    "set confirm             " Включение диалогов с запросами

" --- Indent
    set smarttab      " в случае включения этой опции, нажатие Tab в начале строки (если быть точнее, до первого непробельного символа в строке) приведет к добавлению отступа, ширина которого соответствует shiftwidth (независимо от значений в tabstop и softtabstop). Нажатие на Backspace удалит отступ, а не только один символ, что очень полезно при включенной expandtab. Напомню: опция оказывает влияние только на отступы в начале строки, в остальных местах используются значения из tabstop и softtabstop.
    set tabstop=4     " количество пробелов, которыми символ табуляции отображается в тексте. Оказывает влияние как на уже существующие табуляции, так и на новые. В случае изменения значения, «на лету» применяется к тексту
    set softtabstop=4 " количество пробелов, которыми символ табуляции отображается при добавлении. Несмотря на то, что при нажатии на Tab вы получите ожидаемый результат (добавляется новый символ табуляции), фактически в отступе могут использоваться как табуляция так и пробелы. Например, при установленных tabstop равной 8 и softtabstop равной 4, троекратное нажатие Tab приведет к добавлению отступа шириной 12 пробелов, однако сформирован он будет из одного символа табуляции и 4 пробелов.
    set shiftwidth=4  " по умолчанию используется для регулирование ширины отступов в пробелах, добавляемых командами >> и <<. Если значение опции не равно tabstop, как и в случае с softtabstop, отступ может состоять как из символов табуляций так и из пробелов. При включении опции — smarttab, оказывает дополнительное влияние.
    set expandtab     " в режиме вставки заменяет символ табуляции на соответствующее количество пробелов. Так же влияет на отступы, добавляемые командами >> и <<
    "set autoindent   " копирует отступы с текущей строки при добавлении новой
    "
    au BufRead,BufNewFile *.ejs setfiletype html
    au BufRead,BufNewFile *.json setfiletype javascript
    autocmd FileType html       setlocal sw=2 ts=2 sts=2 textwidth=0    " HTML (tab width 2 chr, no wrapping)
    autocmd FileType htmldjango setlocal sw=2 ts=2 sts=2 textwidth=0
    autocmd FileType python     setlocal sw=4 ts=4 sts=4 " textwidth=79   " Python (tab width 4 chr, wrap at 79th char)
    autocmd FileType css        setlocal sw=2 ts=2 sts=2 " textwidth=79   " CSS (tab width 2 chr, wrap at 79th char)
    autocmd FileType javascript setlocal sw=2 ts=2 sts=2 " textwidth=79   " JavaScript (tab width 2 chr, wrap at 79th)


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
    au BufEnter *.py :call RemoveTrailingSpaces()

    " подсвечиваем строки длиннее 80 символов
    au FileType python highlight OverLength ctermbg=darkred ctermfg=white
    au FileType python match OverLength /\%80v.\+/

    " запуск скриптов
    au FileType python map <F5> :w\|!python %<cr>

    " http://www.vim.org/scripts/script.php?script_id=790 
    Bundle 'vim-scripts/python.vim--Vasiliev'
    " http://www.vim.org/scripts/script.php?script_id=1487
    Bundle 'vim-scripts/django.vim'
    " http://www.vim.org/scripts/script.php?script_id=2441
    Bundle 'vim-scripts/pyflakes.vim'

" --- HTML
    " подсвечиваем строки длиннее 80 символов
    au FileType javascript highlight OverLength ctermbg=darkred ctermfg=white
    au FileType javascript match OverLength /\%80v.\+/

    " http://www.vim.org/scripts/script.php?script_id=2075
    Bundle 'vim-scripts/indenthtml.vim'

" --- JS
    " перед сохранением вырезаем пробелы на концах
    au BufWritePre *.js normal m`:%s/\s\+$//e ``
    " удалем пробелы на концах строк 
    au BufEnter *.js :call RemoveTrailingSpaces()

    " запуск скриптов
    au FileType javascript map <F5> :w\|!node %<cr>

    " http://www.vim.org/scripts/script.php?script_id=3081
    Bundle 'vim-scripts/JavaScript-Indent'

" --- Plugins
    Bundle 'noah/vim256-color.git'
    set t_Co=256

    Bundle 'msanders/snipmate.vim'
    let snippets_dir = '~/.vim/snippets'

    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'


" --- omnicomletion
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS

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

" переопределяю leader key
    "let mapleader = " "


" Setting up the command mode in russian layout
    map ё `
    map й q
    map ц w
    map у e
    map к r
    map е t
    map н y
    map г u
    map ш i
    map щ o
    map з p
    map х [
    map ъ ]
    map ф a
    map ы s
    map в d
    map а f
    map п g
    map р h
    map о j
    map л k
    map д l
    map ж ;
    map э '
    map я z
    map ч x
    map с c
    map м v
    map и b
    map т n
    map ь m
    map б ,
    map ю .
    map Ё ~
    map Й Q
    map Ц W
    map У E
    map К R
    map Е T
    map Н Y
    map Г U
    map Ш I
    map Щ O
    map З P
    map Х {
    map Ъ }
    map Ф A
    map Ы S
    map В D
    map А F
    map П G
    map Р H
    map О J
    map Л K
    map Д L
    map Ж :
    map Э "
    map Я Z
    map Ч X
    map С C
    map М V
    map И B
    map Т N
    map Ь M
    map Б <
    map Ю >

" Удалить пробелы в конце строк
    function! RemoveTrailingSpaces()
       normal! mzHmy
       execute '%s:\s\+$::ge'
       normal! 'yzt`z
    endfunction

" Auto install bundles first starting time
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif

color wombat256
