" MODELINE AND NOTES"{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

"}

" ENVIRONMENT"{
" ===========

" According OS"{
" ------------

silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction

silent function! CYGWIN()
    return has('win32unix')
endfunction


"}

" Shell according to system"{
if !WINDOWS()
    set shell=/bin/bash
endif
"}

" Unix"{
" ----

if has('unix')
    let $VIMHOME=$HOME . "/.vim"
    let $VIMBUNDLE=$VIMHOME . "/bundle"

    set guifont=Inconsolata\ 14
endif
"}

" Windows"{
" -------

if has('win32') || has('win64')
    let $VIMHOME=getcwd()
    let $VIMHOME=$VIMHOME . '\Data\settings\.vim\'
    behave mswin

    set guifont=Consolas:h12
    set clipboard=unnamed
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    if has("multi_byte")
        set termencoding=cp850
        set encoding=utf-8
        setglobal fileencoding=utf-8
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
    endif
endif
"}

" Mac"{
" ---

if has('macunix')
    set guifont=Menlo:h12
    set clipboard=unnamed
endif


set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h20


"}
"}

" CUSTOMIZE EVERYTHING WITH VIMRC.BEFORE"{
" ======================================

" Use before config if available"{
if filereadable(expand("$HOME/.vimrc.before"))
    source $HOME/.vimrc.before
endif
"}
"}

" BUILTIN OPTIONS"{
" ===============

" Appearance"{
" ----------

set background=dark
"set colorcolumn=80
"set colorcolumn=+1
"set cursorcolumn
set cursorline
set fillchars=
set ruler
set laststatus=2
set number
set numberwidth=3
"set statusline=%f\ %m\ %r\ %y\ [%{&fileencoding}]\ [len\ %L:%p%%]
"set statusline+=\ [pos\ %02l:%02c\ 0x%O]\ [chr\ %3b\ 0x%02B]\ [buf\ #%n]


"}

" Behavior"{
" --------

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
scriptencoding utf-8

syntax on

set backspace=indent,eol,start
set viewdir=$VIMHOME/tmp/view
set backupdir=$VIMHOME/tmp/backup
set undodir=$VIMHOME/tmp/undo
set hidden
set splitright
set splitbelow
set noshowmode
set tabpagemax=15
set history=1024
set whichwrap=b,s,h,l,<,>,[,]
set title
set virtualedit=onemore

set wildmenu
set wildmode=list:longest,full
set suffixes=.o,.h,.bak,.info,.log,~,.out
set wildignorecase
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,tags,*.bak,*~

set foldenable
"set foldlevelstart=0

set viewoptions=folds,options,cursor,unix,slash
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set noswapfile

if !isdirectory($VIMHOME . "/tmp/view")
    call mkdir($VIMHOME . "/tmp/view", "p")
endif
if !isdirectory($VIMHOME . "/tmp/backup")
    call mkdir($VIMHOME . "/tmp/backup", "p")
endif
if !isdirectory($VIMHOME . "/tmp/undo")
    call mkdir($VIMHOME . "/tmp/undo", "p")
endif

if has('persistent_undo')
    set undofile
    set undolevels=2048
    set undoreload=10000
endif

set undodir=$VIMHOME/tmp/undo

set list
set listchars=nbsp:%
set listchars+=tab:>-
set listchars+=trail:~
set listchars+=extends:>
set listchars+=precedes:<
set listchars+=eol:$

set showbreak=-

if has('balloon_eval') && has('unix')
    set ballooneval
endif
"}

" Search"{
" --------

"noremap / /\v
"noremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase

set magic
set showmatch
set matchtime=1
"}

" Errors"{
" --------------

set noerrorbells
set novisualbell
"set t_vb
"}

" Indent"{
" --------

set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
"}

" Filetype"{
" --------


"}

"}

" MAPPINGS"{
" ========


let mapleader=","

set pastetoggle=<F12>
au InsertLeave * set nopaste


" Indent multiple lines with TAB
vmap <Tab> >
vmap <S-Tab> <

" To clear search highlighting rather than toggle it and off
noremap <silent> <leader><space> :nohlsearch<CR>

" Resource configuration editing.
nmap <silent> <leader>v :vsplit $MYVIMRC<CR>
nmap <silent> <leader>s :source $MYVIMRC<CR>

" Save when losing focus
au FocusLost * :wa

nnoremap q :q!<cr>
nnoremap <leader>q :qa!<cr>

" Keep hands on the keyboard
inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>

" Wrapped lines goes down/up to next row, rather than next line in file
nnoremap <silent> k :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'k' : 'gk')<Enter>
nnoremap <silent> j :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'j' : 'gj')<Enter>


" Switch different kind line number
nnoremap <leader>, :call NumberToggle()<cr>

" Save when losing focus
au FocusLost * :wa

nnoremap q :q!<cr>
nnoremap <leader>q :qa!<cr>

" Keep hands on the keyboard
inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>

nnoremap <space> za
vnoremap <space> zf

" Window navigation
map <C-J> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_


" AUTOCOMMANDS
" ============

augroup MYVIMRC
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


augroup TEXT
    au!
    " Automatically save session on exit.
    au VimLeave * call SaveSession()
    " Navigate line by line through wrapped text (skip wrapped lines).
    au BufReadPre * imap <UP> <ESC>gka
    au BufReadPre * imap <DOWN> <ESC>gja
    " Navigate row by row through wrapped text.
    au BufReadPre * nmap k gk
    au BufReadPre * nmap j gj
    " Correct filetype detection for *.md files.
    au BufRead,BufNewFile *.md set filetype=markdown
augroup END


augroup PROGRAMMING
    au BufRead,BufNewFile *.html set shiftwidth=2
    au BufRead,BufNewFile *.html set softtabstop=2
    au BufRead,BufNewFile *.html set tabstop=2 
    au FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,perl autocmd BufWritePre <buffer> if !exists('g:billinux_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif

augroup END


augroup NUMBER
    au!
    autocmd FocusLost * :set number
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
    autocmd CursorMoved * :set relativenumber
augroup END
"}

" FUNCTIONS"{
" =========

function! NeatFoldText()"{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*' . '\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
"set foldtext=NeatFoldText()
"}

function! LoadSession()"{
    " Load last vim session
    if argc() == 0
        execute 'source $VIMHOME/session.vim'
    endif
endfunction
"}

function! SaveSession()"{
    " Save current vim session.
    execute 'mksession! $VIMHOME/session.vim'
endfunction
"}

function! NumberToggle()"{
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set number
        set relativenumber
endif
endfunc
"}

function! StripTrailingWhitespace()"{
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
"}
"}

" VUNDLE PLUGINS"{
" ==============

" Setting up Vundle - the vim plugin bundler"{

" Install Vundle (plugins manager)"{
" -------------------------------

" http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let iCanHazVundle=1
let vundle_readme=expand('$VIMBUNDLE/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p $VIMBUNDLE
    silent !git clone https://github.com/gmarik/vundle $VIMBUNDLE/vundle
    let iCanHazVundle=0
endif

set rtp+=$VIMBUNDLE/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
"}

" Add dependencies"{
" --------------------



"}

" Add your bundles"{
" --------------------

" Configure bundles to install and load"{
" -------------------------------------

" In your .vimrc.before.local file
" list only the plugin groups you will use
if !exists('g:billinux_bundle_groups')
    let g:billinux_bundle_groups=['general', 'writing', 'neocomplcache', 'programming', 'php', 'ruby', 'python', 'javascript', 'html', 'twig', 'css', 'colors', 'misc',]
endif

" To override all the included bundles, add the following to your
" .vimrc.bundles.local file:
"   let g:override_billinux_bundles = 1
"}

" Bundle groups"{
" -------------

" To prevent installation of extra bundles
" let g:billinux_no_extra_bundles = 1

if !exists("g:override_billinux_bundles")

    " General"{
    " -------

    if count(g:billinux_bundle_groups, 'general')
        Bundle 'scrooloose/nerdtree'
        Bundle 'kien/ctrlp.vim'
        Bundle 'tacahiroy/ctrlp-funky'
        Bundle 'tpope/vim-surround'
        Bundle 'godlygeek/csapprox'
        Bundle 'vim-scripts/conque-shell'
        Bundle 'bling/vim-airline'
        " You have to install pre-patched powerline fonts on your system
        " before installing vim-airline
        " https://www.youtube.com/watch?v=zE3STsWTCcA
        " Bundle 'lokaltog/powerline-fonts'
        Bundle 'bling/vim-bufferline'
        Bundle 'matchit.zip'
        Bundle 'mbbill/undotree'

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'tpope/vim-repeat'
            Bundle 'vim-scripts/figlet.vim'
            Bundle 'spf13/vim-autoclose'
            Bundle 'terryma/vim-multiple-cursors'
            Bundle 'vim-scripts/restore_view.vim'
            Bundle 'vim-scripts/sessionman.vim'
            Bundle 'Lokaltog/vim-easymotion'
            Bundle 'jistr/vim-nerdtree-tabs'
            Bundle 'nathanaelkane/vim-indent-guides'
            Bundle 'mhinz/vim-signify'
            Bundle 'tpope/vim-abolish.git'
            Bundle 'osyo-manga/vim-over'
            Bundle 'kana/vim-textobj-user'
            Bundle 'kana/vim-textobj-indent'
            Bundle 'gcmt/wildfire.vim'
        endif

    endif
"}

    " Writing"{
    " -------



    if count(g:billinux_bundle_groups, 'writing')
        Bundle 'reedes/vim-litecorrect'
        Bundle 'reedes/vim-textobj-sentence'
        Bundle 'reedes/vim-textobj-quote'
        Bundle 'reedes/vim-wordy'
        Bundle 'DrawIt'
    endif
"}

    " General programming"{
    " -------------------

    if count(g:billinux_bundle_groups, 'programming')
        Bundle 'mattn/emmet-vim'
        Bundle 'godlygeek/tabular'
        Bundle 'tpope/vim-fugitive'
        if executable('ctags')
            Bundle 'majutsushi/tagbar'
        endif

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'mattn/webapi-vim'
            Bundle 'mattn/gist-vim'
            Bundle 'scrooloose/nerdcommenter'
        endif
    endif
"}

    " Snippets & AutoComplete"{
    " -----------------------

    if count(g:billinux_bundle_groups, 'snipmate')
        Bundle 'garbas/vim-snipmate'
        Bundle 'honza/vim-snippets'
        " Source support_function.vim to support vim-snippets.
        if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
            source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
        endif
    elseif count(g:billinux_bundle_groups, 'youcompleteme')
        Bundle 'Valloric/YouCompleteMe'
        Bundle 'SirVer/ultisnips'
        Bundle 'honza/vim-snippets'
    elseif count(g:billinux_bundle_groups, 'neocomplcache')
        Bundle 'Shougo/neocomplcache'
        Bundle 'Shougo/neosnippet'
        Bundle 'Shougo/neosnippet-snippets'
        Bundle 'honza/vim-snippets'
    elseif count(g:billinux_bundle_groups, 'neocomplete')
        Bundle 'Shougo/neocomplete.vim.git'
        Bundle 'Shougo/neosnippet'
        Bundle 'Shougo/neosnippet-snippets'
        Bundle 'honza/vim-snippets'
    elseif count(g:billinux_bundle_groups, 'clangcomplete')
        Bundle 'Rip-Rip/clang_complete'
    endif
"}

    " PHP"{
    " ---

    if count(g:billinux_bundle_groups, 'php')
        Bundle 'spf13/PIV'

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'arnaud-lb/vim-php-namespace'
        endif
    endif
"}

    " Python"{
    " ------

    if count(g:billinux_bundle_groups, 'python')
        if executable('python')
            Bundle 'python.vim'
            Bundle 'pythoncomplete'
        endif
    endif
"}

    " Javascript"{
    " ----------

    if count(g:billinux_bundle_groups, 'javascript')
        Bundle 'pangloss/vim-javascript'
        Bundle 'kchmck/vim-coffee-script'
        Bundle 'elzr/vim-json'
        Bundle 'briancollins/vim-jst'
    endif
"}

    " HTML"{
    " ----

    if count(g:billinux_bundle_groups, 'html')
        Bundle 'digitaltoad/vim-jade'
        Bundle 'amirh/HTML-AutoCloseTag'

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'tpope/vim-haml'
            Bundle 'gorodinskiy/vim-coloresque'
        endif
    endif
"}

    " Twig template"{
    " -------------

    if count(g:billinux_bundle_groups, 'twig')
        Bundle 'beyondwords/vim-twig'
    endif
"}

    " CSS"{
    " ---

    if count(g:billinux_bundle_groups, 'css')
        Bundle 'hail2u/vim-css3-syntax'
        Bundle 'wavded/vim-stylus'
    endif
"}

    " Ruby"{
    " ----

    if count(g:billinux_bundle_groups, 'ruby')
        if executable('ruby')
            Bundle 'tpope/vim-rails'
            let g:rubycomplete_buffer_loading = 1
            "let g:rubycomplete_classes_in_global = 1
            "let g:rubycomplete_rails = 1
        endif
    endif
"}

    " Colorschemes"{
    " ------------

    if count(g:billinux_bundle_groups, 'colors')
        Bundle 'altercation/vim-colors-solarized'
        Bundle 'tomasr/molokai'

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'flazz/vim-colorschemes'
        endif
    endif
"}

    " Misc"{
    " ----

    if count(g:billinux_bundle_groups, 'misc')
        Bundle 'tpope/vim-markdown'
    endif
"}

endif

"}
"}

" Install Your bundles and dependencies"{
" -------------------------------------

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
"}

" Setting up Vundle - the vim plugin bundler end
"}

" Turn on filetype recognition, load filetype specific plugins and indents."{
syntax on
filetype plugin indent on
"}
"}

" PLUGIN CONFIG"{
" =============

" General"{
" =-=-=-=

" NERDTree"{
" --------

if isdirectory(expand($VIMBUNDLE . "/nerdtree"))
    imap <leader>e :NERDTreeToggle<cr>
    nmap <leader>e :NERDTreeToggle<cr>
    imap <leader>nt :NERDTreeFind<cr>
    nmap <leader>nt :NERDTreeFind<cr>
endif
"}

" CtrLP"{
" -----

if isdirectory(expand($VIMBUNDLE . "/ctrlp"))
    "let g:ctrlp_map = '<c-p>'
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    " On Windows use "dir" as fallback command.
    if WINDOWS()
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    elseif executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif

    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }

    if isdirectory(expand($VIMBUNDLE . "/ctrlp-funky"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']

        "funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif

endif
"}

" Surround"{
" --------

if isdirectory(expand($VIMBUNDLE . "/vim-surround"))
endif
"}

" CSApprox"{
" --------

if isdirectory(expand($VIMBUNDLE . "/csapprox"))

endif
"}

" Conque-shell"{
" ------------

if isdirectory(expand($VIMBUNDLE . "/conque-shell"))
    nmap <leader>c :ConqueTermSplit bash<cr>
endif
"}

" Airline"{
" -------

if isdirectory(expand($VIMBUNDLE . "/vim-airline"))
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.space = "\ua0"

    let g:airline_powerline_fonts=1

    "let g:airline_theme             = 'powerlineish'
    let g:airline_enable_branch     = 1
    let g:airline_enable_syntastic  = 1

    " vim-powerline symbols
"    let g:airline_left_sep          = '⮀'
"    let g:airline_left_alt_sep      = '⮁'
"    let g:airline_right_sep         = '⮂'
"    let g:airline_right_alt_sep     = '⮃'
"    let g:airline_branch_prefix     = '⭠'
"    let g:airline_readonly_symbol   = '⭤'
"    let g:airline_linecolumn_prefix = '⭡'
endif
"}

" Matchit"{
" -------

if isdirectory(expand($VIMBUNDLE . "/matchit.zip"))
endif
"}

" Undotree"{
" --------

if isdirectory(expand($VIMBUNDLE . "/undotree"))
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif
"}

" Tagbar"{
" ------

if isdirectory(expand($VIMBUNDLE . "/tagbar"))
    nnoremap <silent> <leader>tt :TagbarToggle<CR>

    " If using go please install the gotags program using the following
    " go install github.com/jstemmer/gotags
    " And make sure gotags is in your path

    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
            \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
            \ 'r:constructor', 'f:functions' ],
        \ 'sro' : '.',
        \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
        \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }
endif
"}

"}

" Writing"{
" -------


"}

" Completion"{
" =-=-=-=-=-

" Clang complete (C/C++ autocompletion)
" -------------------------------------

if has('unix')
    let g:clang_use_library=1
    let g:clang_hl_errors=1
    let g:clang_complete_copen=1
    let g:clang_periodic_quickfix=0
    autocmd Filetype c,cpp,cxx,h,hxx autocmd BufWritePre <buffer> :call g:ClangUpdateQuickFix()
endif


"}

" Programming"{
" =-=-=-=-=-=

" Fugitive"{
" --------

if isdirectory(expand($VIMBUNDLE . "/vim-fugitive"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR
endif
"}

" Emmet"{
" -----

if isdirectory(expand($VIMBUNDLE . "/emmet-vim"))
endif
"}

" Tabular"{
" -------

if isdirectory(expand($VIMBUNDLE . "/tabular"))
endif
"}



"}

" PHP"{
" =-=

" PIV"{
" ---

if isdirectory(expand($VIMBUNDLE . "/PIV"))
endif
"}

"}

" Ruby"{
" =-=-


"}

" Python"{
" =-=-=-


"}

" Javascript"{
" =-=-=-=-=-


"}

" HTML"{
" =-=-

" Jade"{
" ----

if isdirectory(expand($VIMBUNDLE . "/vim-jade"))
endif
"}

" Autoclosetag"{
" ------------

if isdirectory(expand($VIMBUNDLE . "/HTML-AutoCloseTag"))
endif
"}

"}

" Twig"{
" =-=-


"}

" CSS"{
" =-=

" Css3 syntax"{
" -----------

if isdirectory(expand($VIMBUNDLE . "/vim-css3-syntax"))
endif
"}

" Stylus"{
" ------

if isdirectory(expand($VIMBUNDLE . "/vim-stylus"))
endif
"}


"}

" Colors"{
" =-=-=-


" REQUIRED for CSApprox
if $TERM =~ '^xterm*'
    set t_Co=256
elseif $TERM =~ '^rxvt*'
    set t_Co=256
elseif $COLORTERM == 'gnome-terminal'
    set t_Co=256
elseif $TERM =~ '^linux'
    set t_Co=8
else
    set t_Co=16
endif

" In your .vimrc.before.local file
" list only the color groups you will use
if !exists('g:billinux_color_groups')
    let g:billinux_color_groups=['molokai', 'solarized',]
endif


if count(g:billinux_color_groups, 'molokai')
    if isdirectory(expand($VIMBUNDLE . "/molokai"))
        let g:molokai_original = 1
        colorscheme molokai

        if isdirectory(expand($VIMBUNDLE . "/vim-airline"))
            let g:airline_theme='molokai'
        endif
    endif
endif

if count(g:billinux_color_groups, 'solarized')
    if isdirectory(expand($VIMBUNDLE . "/vim-colors-solarized"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        colorscheme solarized

        if isdirectory(expand($VIMBUNDLE . "/vim-airline"))
"            let g:airline_theme='solarized'
        endif
    endif
endif


"}

" Misc"{
" =-=-

" Markdown"{
" --------

if isdirectory(expand($VIMBUNDLE . "/vim-markdown"))
endif
"}


"}

"}

" CUSTOM VIMRC & GVIMRC"{
" =====================

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("~/.gvimrc"))
        source ~/.gvimrc
    endif
endif


" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif
"}

" VIM TIPS"{
" ========

" Variables"{
" ---------

" To list all environment variables used by VIM
" :echo $<C-D>
"}

" Indent"{
" -----------

" Vjj>  :To indent a code block
" >%    : Increase indent of a braced or bracketed block (cursor on first brace)
" =%    : Reindent a braced or bracketed block (cursor on first brace)
" %>    : Decrease indent of a braced or bracketed block (cursor on first brace)
" 5>>   : Indent 5 lines
"}

"}

