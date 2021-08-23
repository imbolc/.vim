" === Common
" set mmp=200000  # diff of huge files
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

syntax enable
set ttyfast
set history=50          " history of commands
set undolevels=500      " history of undos
set title               " change the terminal's title
set titleold=           " restore the title back on exit

set inccommand=split    " preview substitutions[

nnoremap Q <nop> " disable ex-mode

" set statusline=%<%f%h%m%r%=\ %l,%c%V\ %P
" set rulerformat=%30(%=%f\ %P%)
" set rulerformat=%{winwidth(0)}(%=%f\ %P%)
" autocmd BufEnter * redraw! | echo @% =~ '^\/' ? @% : './' . @%

" Show command line only with filename in it
set laststatus=1
set rulerformat=%15(%=%l,%c\ %P%)
function _get_commandline_filename()
    let filename = @% =~ '^\/' ? @% : './' . @%
    " window width - pressed keys place - ruller, so it fits into a line
    let max = winwidth(0) - 11 - 16
    if len(filename) > max
        let filename = "<" . strcharpart(filename, len(filename) - max + 1)
    endif
    return filename
endfunction
autocmd BufEnter * redraw! | echo _get_commandline_filename()

"set cursorline          " Highlight current line 
set showcmd             " display incomplete commands
set autoread            " automatically re-read changed files, works only in GUI
set autowrite           " automatically :write before running commands
set foldmethod=syntax
set foldlevelstart=200  " open all folds when opening a file
set mouse=
imap <F5> <Esc><F5>
filetype plugin indent on
set spelllang=ru,en
set number
set relativenumber
set shortmess+=c  " Avoid showing extra messages when using completion
set signcolumn=no " Don't show an additional column signaling about errors on the left side

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Suggestions with built-in fuzzy search eg :vs **/*<foo><Tab>
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,
set wildignore+=*.pdf,*.psd
set wildignore+=**node_modules/*
set wildignore+=**/migrations/*     " django migrations
set wildignore+=**/site-packages/*  " python libs in virtualenv
set wildignore+=**/__pycache__/*

" Show trailing whitespace chars
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
highlight SpecialKey ctermfg=grey guifg=grey70

" Indentation
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

" Search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,cp866,ucs-bom,ascii
set fileformat=unix
set fileformats=unix,dos,mac

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Switching between tabs by <Tab> / <Shift-Tab>
nnoremap <tab> gt
nnoremap <s-tab> gT

" Moving up and down through softly wrapped text
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Switch to normal mode in terminal by escape
tnoremap <Esc> <C-\><C-n>

" Templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.vue 0r ~/.vim/templates/skeleton.vue
    autocmd BufNewFile *.svelte 0r ~/.vim/templates/skeleton.svelte
  augroup END
endif


" command! -nargs=1 ChangeExt execute "saveas ".expand("%:p:r").<q-args>

call plug#begin()

" === Language Server Protocol
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" " Rust-tools related
" Plug 'simrat39/rust-tools.nvim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'


Plug 'editorconfig/editorconfig-vim'

" Svelte
Plug 'evanleck/vim-svelte'

" " Auto brackets
" Plug 'jiangmiao/auto-pairs'

" Clang
au FileType c map <buffer> <F5> :w\|!gcc % -o /tmp/% && /tmp/%<cr>

" Python
let g:python3_host_prog = expand('~/.vim/py3env/bin/python')
let python_highlight_all = 1
au FileType python map <buffer> <F5> :w\|!python %<cr>
Plug 'mitsuhiko/vim-python-combined'
Plug 'lepture/vim-jinja'
Plug 'raimon49/requirements.txt.vim'

" JavaScript
au FileType javascript map <buffer> <F5> :w\|!node --harmony %<cr>
Plug 'pangloss/vim-javascript'

" SQL
au FileType sql map <buffer> <F5> :w\|!psql -f %<cr>
Plug 'lifepillar/pgsql.vim'
let g:sql_type_default = 'pgsql'


" :CocInstall coc-rust-analyzer
" :CocInstall coc-python
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


Plug 'w0rp/ale'
let g:ale_linters = {
\   'html': ['eslint'],
\   'javascript': ['eslint'],
\   'python': ['flake8', 'mypy'],
\   'svelte': ['eslint'],
\}
let g:ale_fixers = {
\   'html': ['eslint'],
\   'javascript': ['eslint'],
\   'svelte': ['eslint'],
\   'python': ['isort', 'black'],
\}
let g:ale_fix_on_save = 1
let g:ale_virtualenv_dir_names = ['var/env', '.env', '.venv', 'env', 'venv']
let g:ale_python_black_options = '--line-length 79'
map <leader>e <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Markdown
" reformat: gq
au FileType markdown setlocal wrap
" au FileType markdown setlocal textwidth=79
au FileType markdown setlocal spell
au FileType markdown setlocal conceallevel=2
au FileType markdown vnoremap g gq
" cargo install comrak
au FileType markdown map <buffer> <F5> :w\|!comrak --unsafe -e table % > /tmp/vim.md.html && xdg-open /tmp/vim.md.html<cr>
" automatically reformat paragraph on leaving insert mode
" au InsertLeave *.md normal gwap<CR>

Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_frontmatter = 1

" Yaml
au FileType yaml setlocal wrap
au FileType yaml setlocal spell

" Vue
Plug 'posva/vim-vue'

" " " === Prettier
" Plug 'prettier/vim-prettier', {
"     \ 'do': 'npm install',
"     \ 'for': [
"         \ 'javascript',
"         \ 'json',
"         \ 'css',
"         \ 'markdown',
"         \ 'vue',
"         \ 'graphql'
"     \ ] }
" let g:prettier#config#semi = 'false'
" let g:prettier#config#single_quote = 'true'


" Colors
set t_Co=256
set background=light
highlight ColorColumn ctermbg=white

" use f8 / shift+f8 to switch schemes
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-colorscheme-switcher'

" Plug 'vim-scripts/wombat256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'clinstid/eink.vim'
" Plug 'scheakur/vim-scheakur'
" Plug 'rakr/vim-one'



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
Plug 'junegunn/fzf.vim'
let g:fzf_action = {'return': 'vsplit'}
" let $FZF_DEFAULT_COMMAND = 'ag -g ""' " honor .gitignore
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --hidden -g "!{package-lock.json,Cargo.lock}"'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --no-heading --line-number --column --smart-case --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': notes_path}, 'right:50%'),
  \   <bang>0)
map <leader>n :Rg<cr>
map <leader>c :execute 'tabe' notes_path<cr>

" Autocompletion

" Trigger completion with <tab>
" found in :help completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <buffer> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)


" " Enable omni completion.
" " omnifuncs
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Mizuchi/vim-ranger'
map <leader>r :w\|:tabe %:p:h<cr>

" map <leader>n :tabe ~/Yandex.Disk/Documents/notes.md<cr>

Plug 'cespare/vim-toml'

" === Rust
au Filetype rust set colorcolumn=100
Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
let g:rustfmt_autosave = 1  " format code on save
let g:rust_fold = 1  " turn on folding
let g:rustfmt_fail_silently = 1  " prevent 'rustfmt' from populating the location-list with errors
" au FileType rust nnoremap <buffer> <F5> :w\|!rustc --edition=2018 % -o /tmp/vim.rs && /tmp/vim.rs && rm /tmp/vim.rs<cr>

" cargo install rust-script
au FileType rust nnoremap <buffer> <F5> :w\|!rust-script %<cr>

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'python': ['pyls'],
"     \ }
" " apply key mappings to all filetypes supported by LanguageClient
" function LC_maps()
"     if has_key(g:LanguageClient_serverCommands, &filetype)
"         nnoremap <silent> gd :call LanguageClient#textDocument_definition({'gotoCmd': 'tabnew'})<CR>
"         nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR><C-W><C-W>
"     endif
" endfunction
" autocmd FileType * call LC_maps()
" " autocmd CursorMoved * if &previewwindow != 1 | pclose | endif

Plug 'timonv/vim-cargo'
" autocmd BufNewFile,BufReadPost main.rs setlocal filetype=cargo  textwidth=80
au FileType cargo nnoremap <buffer> <F5> :CargoRun<cr>

" === Tables
" `:TableModeToggle` to enter table mode
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'  " markdown-compatible corners

" Use `||` in insert mode to enter table mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction
inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'

" " Vlang
" Plug 'ollykel/v-vim'
" au FileType vlang map <buffer> <F5> :w\|!v run %<cr>

" CSV
Plug 'mechatroner/rainbow_csv'

" Auto paste mode
Plug 'ConradIrwin/vim-bracketed-paste'

" Nim
Plug 'zah/nim.vim'
au FileType nim map <buffer> <F5> :w\|!nim c -r -d:ssl %<cr>

" Tmux splits integration
Plug 'christoomey/vim-tmux-navigator'

" " Golang
" Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }
" au FileType go map <buffer> <F5> :w\|!go run %<cr>

" Bash
au FileType sh map <buffer> <F5> :w\|!bash %<cr>

" Sparql
Plug 'rvesse/vim-sparql'

"=== Writing
" Distraction-free mode - adds `Goyo` command
Plug 'junegunn/goyo.vim'

call plug#end()

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


" Toggle spell-checking
    function! ToggleSpellCheck()
        set spell!
        if &spell
            echo "Spellcheck ON"
        else
            echo "Spellcheck OFF"
        endif
    endfunction

    map <F9> <Esc>:call ToggleSpellCheck()<CR>

" setl signcolumn=no

" hi mkdCode ctermbg=lightgreen
hi markdownCodeBlockBG ctermbg=230
sign define codeblock linehl=markdownCodeBlockBG

function! MarkdownBlocks()
    let l:continue = 0
    execute "sign unplace * file=".expand("%")

    " iterate through each line in the buffer
    for l:lnum in range(1, len(getline(1, "$")))
        " detect the start fo a code block
        if getline(l:lnum) =~ "^```.*$" || l:continue
            " continue placing signs, until the block stops
            let l:continue = 1
            " place sign
            execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
            " stop placing signs
            if getline(l:lnum) =~ "^```$"
                let l:continue = 0
            endif
        endif
    endfor
endfunction

" Use signs to highlight code blocks
" Set signs on loading the file, leaving insert mode, and after writing it
au InsertLeave *.md call MarkdownBlocks()
au BufEnter *.md call MarkdownBlocks()
au BufWritePost *.md call MarkdownBlocks()

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste


" === LSP Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" rust-analyzer does not yet support goto declaration
" re-mapped `gd` to definition
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" TODO Show diagnostic popup on cursor hover
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

" === Rust LSP

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
-- nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
-- https://rust-analyzer.github.io/manual.html#nvim-lsp
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- imbolc test
-- nvim_lsp.pyls.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- errors always visible right to the code line
    virtual_text = true,

    -- show signs (as the left colume)
    signs = true,

    -- update diagnostic in insert mode
    update_in_insert = false,
  }
)

-- -- Rust tools
-- local opts = {
--     tools = { -- rust-tools options
--         -- automatically set inlay hints (type hints)
--         -- There is an issue due to which the hints are not applied on the first
--         -- opened file. For now, write to the file to trigger a reapplication of
--         -- the hints or just run :RustSetInlayHints.
--         -- default: true
--         autoSetHints = true,
--
--         -- whether to show hover actions inside the hover window
--         -- this overrides the default hover handler
--         -- default: true
--         hover_with_actions = true,
--
--         runnables = {
--             -- whether to use telescope for selection menu or not
--             -- default: true
--             use_telescope = true
--
--             -- rest of the opts are forwarded to telescope
--         },
--
--         inlay_hints = {
--             -- wheter to show parameter hints with the inlay hints or not
--             -- default: true
--             show_parameter_hints = true,
--
--             -- prefix for parameter hints
--             -- default: "<-"
--             parameter_hints_prefix = "← ",
--
--             -- prefix for all the other hints (type, chaining)
--             -- default: "=>"
--             other_hints_prefix  = "⇒ ",
--
--             -- whether to align to the lenght of the longest line in the file
--             max_len_align = false,
--
--             -- padding from the left if max_len_align is true
--             max_len_align_padding = 1,
--
--             -- whether to align to the extreme right or not
--             right_align = false,
--
--             -- padding from the right if right_align is true
--             right_align_padding = 7,
--         },
--
--         hover_actions = {
--             -- the border that is used for the hover window
--             -- see vim.api.nvim_open_win()
--             border = {
--               {"╭", "FloatBorder"},
--               {"─", "FloatBorder"},
--               {"╮", "FloatBorder"},
--               {"│", "FloatBorder"},
--               {"╯", "FloatBorder"},
--               {"─", "FloatBorder"},
--               {"╰", "FloatBorder"},
--               {"│", "FloatBorder"}
--             },
--         }
--     },
--
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--     server = {}, -- rust-analyer options
-- }
--
-- require('rust-tools').setup(opts)
EOF

