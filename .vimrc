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

" --- Indent
    set smarttab      " в случае включения этой опции, нажатие Tab в начале строки (если быть точнее, до первого непробельного символа в строке) приведет к добавлению отступа, ширина которого соответствует shiftwidth (независимо от значений в tabstop и softtabstop). Нажатие на Backspace удалит отступ, а не только один символ, что очень полезно при включенной expandtab. Напомню: опция оказывает влияние только на отступы в начале строки, в остальных местах используются значения из tabstop и softtabstop.
    set tabstop=4     " количество пробелов, которыми символ табуляции отображается в тексте. Оказывает влияние как на уже существующие табуляции, так и на новые. В случае изменения значения, «на лету» применяется к тексту
    set softtabstop=4 " количество пробелов, которыми символ табуляции отображается при добавлении. Несмотря на то, что при нажатии на Tab вы получите ожидаемый результат (добавляется новый символ табуляции), фактически в отступе могут использоваться как табуляция так и пробелы. Например, при установленных tabstop равной 8 и softtabstop равной 4, троекратное нажатие Tab приведет к добавлению отступа шириной 12 пробелов, однако сформирован он будет из одного символа табуляции и 4 пробелов.
    set expandtab     " в режиме вставки заменяет символ табуляции на соответствующее количество пробелов. Так же влияет на отступы, добавляемые командами >> и <<
    set shiftwidth=4  " по умолчанию используется для регулирование ширины отступов в пробелах, добавляемых командами >> и <<. Если значение опции не равно tabstop, как и в случае с softtabstop, отступ может состоять как из символов табуляций так и из пробелов. При включении опции — smarttab, оказывает дополнительное влияние.
    set autoindent    " копирует отступы с текущей строки при добавлении новой
    
    au BufRead,BufNewFile *.ejs		setlocal filetype=html
    au BufRead,BufNewFile *.tag		setlocal filetype=html
    " au BufRead,BufNewFile *.html	setlocal filetype=htmljinja
    " au BufRead,BufNewFile *.jinja2	setlocal filetype=htmljinja
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

    Bundle 'mitsuhiko/vim-python-combined'
    Bundle 'vim-scripts/django.vim'

    Bundle 'tmhedberg/SimpylFold'

" --- HTML
    " Bundle 'mitsuhiko/vim-jinja'
    Bundle 'Glench/Vim-Jinja2-Syntax'
    Bundle 'othree/html5.vim'


" --- Less
    Bundle 'groenewege/vim-less'

" --- JSX
    " Bundle 'mxw/vim-jsx'

" --- Jade
    Bundle 'digitaltoad/vim-jade'

" --- JS
    " подсвечиваем строки длиннее 100 символов
    " au FileType javascript highlight OverLength ctermbg=darkred ctermfg=white
    " au FileType javascript match OverLength /\%100v.\+/

    " перед сохранением вырезаем пробелы на концах
    " au BufWritePre *.js normal m`:%s/\s\+$//e ``
    " удалем пробелы на концах строк 
    " au BufEnter *.js :call RemoveTrailingSpaces()

    " запуск скриптов
    au FileType javascript map <buffer> <F5> :w\|!iojs %<cr>
    
    " Bundle 'hallettj/jslint.vim'
    " http://www.vim.org/scripts/script.php?script_id=3081
    " Bundle 'vim-scripts/JavaScript-Indent'
    Bundle 'pangloss/vim-javascript'
    " let b:javascript_fold=0

    " disable jsLint for json
    " au BufRead,BufNewFile *.json 	let g:JSLintHighlightErrorLine = 0

    " coffee script
    " filetype off
    " Bundle 'kchmck/vim-coffee-script'
    " filetype on

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
    let g:syntastic_check_on_open=1
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
    autocmd FileType jinja let &l:commentstring='{# %s #}'
    let NERDSpaceDelims=1

    Bundle 'scrooloose/nerdtree'

    " коммандный режим в русской раскладке
    Bundle 'powerman/vim-plugin-ruscmd'

    Bundle 'godlygeek/tabular'

    Bundle 'kien/ctrlp.vim'
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    
    Bundle 'editorconfig/editorconfig-vim'

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
    " Bundle 'Shougo/neocomplete.vim'
    " let g:neocomplete#enable_at_startup = 1
    Bundle 'Shougo/neocomplcache.vim'
    let g:neocomplcache_enable_at_startup = 1

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Bundle 'szw/vim-ctrlspace'
Bundle 'djoshea/vim-autoread'


color wombat256mod

" Compatible with ranger 1.4.2 through 1.6.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.
function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'tabedit ' . fnameescape(names[0])
    " exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>
