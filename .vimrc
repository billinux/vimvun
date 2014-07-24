" MODELINE AND NOTES"{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:


"}

" REQUIRED"{
" ========

" Must be first"{
" -------------
set nocompatible
syntax on
filetype off
"}
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
scriptencoding utf-8
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
endif
"}

" Windows"{
" -------

if has('win32') || has('win64')
    let $VIMHOME=getcwd()
    let $VIMHOME=$VIMHOME . '\Data\settings\.vim\'
    behave mswin

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
    set clipboard=unnamed
endif




"}
"}

" VIMRC.PRIVATE && VIMRC.BEFORE"{
" ======================================

" Use before config if available"{
if filereadable(expand("$HOME/.vimrc.before"))
    source $HOME/.vimrc.before
endif
"}

" Use private config if available"{
if filereadable(expand("$HOME/.vimrc.private"))
    source $HOME/.vimrc.private
endif
"}

"}

" BUILTIN OPTIONS"{
" ===============

" Appearance"{
" ----------

set background=dark
set number
set numberwidth=3
set ruler
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set noshowmode

set cursorline
autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline


"}

" Behavior"{
" --------

set backspace=indent,eol,start
set viewdir=$VIMHOME/.cache/view
set backupdir=$VIMHOME/.cache/backup
set hidden
set splitright
set splitbelow
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

" VERY useful to restore view
set viewoptions=folds,options,cursor,unix,slash
" To preserve views of the files (includes folds)
if exists("g:loaded_restore_view")
    finish
endif
let g:loaded_restore_view = 1


if !exists("g:skipview_files")
    let g:skipview_files = []
endif

set noswapfile

if !isdirectory($VIMHOME . "/.cache/view")
    call mkdir($VIMHOME . "/.cache/view", "p")
endif
if !isdirectory($VIMHOME . "/.cache/backup")
    call mkdir($VIMHOME . "/.cache/backup", "p")
endif

if has('persistent_undo')
    if !isdirectory($VIMHOME . "/.cache/undo")
        call mkdir($VIMHOME . "/.cache/undo", "p")
    endif
    set undodir=$VIMHOME/.cache/undo
    set undofile
    set undolevels=2048
    set undoreload=10000
endif

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
set matchtime=2
"}

" Errors"{
" --------------

set noerrorbells
set novisualbell
set timeoutlen=500
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
let g:mapleader=","

" Map <F11> to / (search) and Ctrl-<F11> to ? (backwards search)
map <F11> /
map <C-F11> ?

" Paste toggles
set pastetoggle=<F12>
au InsertLeave * set nopaste

" Indent multiple lines with TAB
vmap <Tab> >
vmap <S-Tab> <
" Keep visual selection after identing
vnoremap < <gv
vnoremap > >gv

" To clear search highlighting rather than toggle it and off
noremap <silent> <leader><space> :nohlsearch<CR>

" Resource configuration editing.
nmap <silent> <leader>v :vsplit $MYVIMRC<CR>
nmap <silent> <leader>s :source $MYVIMRC<CR>

" Save when losing focus
au FocusLost * :wa

" write to a file using sudo
cmap w!! %!sudo tee > /dev/null %

nnoremap q :q!<cr>
nnoremap <leader>q :qa!<cr>

" Keep hands on the keyboard
inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" Unmap arrow keys
noremap <Up> <c-W>k
noremap <Down> <c-W>j
noremap <Left> :bprev <CR>
noremap <Right> :bnext<CR>

" Home row jump to start and end of line
noremap H ^
noremap L $

" Treat long lines as break lines (useful when moving around in them)
nnoremap <silent> k :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'k' : 'gk')<Enter>
nnoremap <silent> j :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'j' : 'gj')<Enter>

" Yank to Clipboard 
nnoremap <C-y> "+y
vnoremap <C-y> "+y

" Switch different kind line number
nnoremap <leader>, :call NumberToggle()<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>mm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"nnoremap <space> za
"vnoremap <space> zf

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"map <C-J> <C-W>j<C-W>_
"map <C-k> <C-W>k<C-W>_
"map <C-h> <C-W>h<C-W>_
"map <C-l> <C-W>l<C-W>_

" Adjust viewports to the same size
map <Leader>= <C-w>=
"}

" AUTOCOMMANDS"{
" ============

" Vimrc"{
" -----

augroup VIMRC
    au!
    autocmd BufWritePost  ~/.vimrc source ~/.vimrc
augroup END
"}

" Text"{
" ----

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
"}

" Programming"{
" -----------

augroup PROGRAMMING
    au BufRead,BufNewFile *.html set shiftwidth=2
    au BufRead,BufNewFile *.html set softtabstop=2
    au BufRead,BufNewFile *.html set tabstop=2
    au FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,perl autocmd BufWritePre <buffer> if !exists('g:billinux_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
augroup END
"}

" Number"{
" ------

augroup NUMBER
    au!
    autocmd FocusLost * :set number
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
    autocmd CursorMoved * :set relativenumber
augroup END
"}

" Autoview"{
" --------

augroup AUTOVIEW
    au!
    " Autosave & Load Views (?* or *).
    autocmd BufWritePost,WinLeave,BufWinLeave * if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter * if MakeViewCheck() | silent! loadview | endif
augroup END
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
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
if executable('ag')
    Bundle 'mileszs/ack.vim'
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
elseif executable('ack-grep')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    Bundle 'mileszs/ack.vim'
elseif executable('ack')
    Bundle 'mileszs/ack.vim'
endif

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
        Bundle 'shougo/unite.vim'
        Bundle 'tpope/vim-surround'
        Bundle 'godlygeek/csapprox'
        Bundle 'shougo/vimshell.vim'
        Bundle 'bling/vim-airline'
        " You have to install pre-patched powerline fonts on your system
        " before installing vim-airline
        " https://www.youtube.com/watch?v=zE3STsWTCcA
        " Bundle 'lokaltog/powerline-fonts'
        Bundle 'bling/vim-bufferline'
        Bundle 'matchit.zip'
        Bundle 'mbbill/undotree'
        Bundle 'Lokaltog/vim-easymotion'

        if !exists('g:billinux_no_extra_bundles')
            Bundle 'tpope/vim-repeat'
            Bundle 'vim-scripts/figlet.vim'
            Bundle 'spf13/vim-autoclose'
            Bundle 'terryma/vim-multiple-cursors'
            Bundle 'vim-scripts/restore_view.vim'
            Bundle 'vim-scripts/sessionman.vim'
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
            Bundle 'scrooloose/syntastic'
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
        Bundle 'lilydjwg/colorizer'
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
        Bundle 'reedes/vim-thematic'

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
filetype plugin indent on
syntax on

"}
"}

" PLUGIN CONFIG"{
" =============

" General"{
" =-=-=-=

" NERDTree"{
" --------

if isdirectory(expand($VIMBUNDLE . "/nerdtree"))
    let g:NERDShutUp=1
    let NERDTreeIgnore=['\~$', '\.swp$', '\.git']
    imap <leader>e :NERDTreeToggle<cr>
    nmap <leader>e :NERDTreeToggle<cr>
    imap <leader>nt :NERDTreeFind<cr>
    nmap <leader>nt :NERDTreeFind<cr>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swp$', '\.git', '\.hg', '\.svn']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif
"}

" CtrLP"{
" -----

if isdirectory(expand($VIMBUNDLE . "/ctrlp"))
    nnoremap <silent> <leader>t :CtrlP<CR>
    nnoremap <silent> <leader>r :CtrlPMRU<CR>

    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'

    " search for nearest ancestor like .git, .hg, and the directory of the current file
    let g:ctrlp_working_path_mode = 'ra'

    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    " Show the match window at the top of the screen
    let g:ctrlp_match_window_bottom = 1

    " Maxiumum height of match window
    let g:ctrlp_max_height = 8

    " Jump to a file if it's open already
    let g:ctrlp_switch_buffer = 'et'

    " Enable caching
    let g:ctrlp_use_caching = 1

    " Speed up by not removing clearing cache evertime
    let g:ctrlp_clear_cache_on_exit=0

    " Show me dotfiles
    let g:ctrlp_show_hidden = 1

    " Number of recently opened files
    let g:ctrlp_mruf_max = 250

    " On Windows use 'dir' as fallback command.
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

" Unite"{
" -----

if isdirectory(expand($VIMBUNDLE . "/unite.vim"))
    " Recently edited files can be searched with <Leader>m
    nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>

    " Open buffers can be navigated with <Leader>b
    nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

    " My application can be searched with <Leader>f
    nnoremap <Leader>f :Unite grep:.<cr>

    " CtrlP search
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_rec/async','sorters','sorter_rank')
    " replacing unite with ctrl-p
    nnoremap <silent> <C-s-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

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

" Vimshell"{
" ------------

if isdirectory(expand($VIMBUNDLE . "/vimshell.vim"))
endif
"}

" Airline"{
" -------

" http://www.4thinker.com/vim-airline.html

" Procedure for installing vim-airline :
" 1. Install powerline fonts and symbols :
"   cd ~/.fonts
"   git clone https://github.com/Lokaltog/powerline-fonts
"   git clone https://github.com/runsisi/consolas-font-for-powerline
"   wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
"   wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
"   Merge the contents of 10-powerline-symbols.conf to ~/.fonts.conf
"   fc-cache -vf ~/.fonts 

" 2. To view symbols ans specials characters in terminal :
"   gnome-terminal: change the default text font
"   rxvt-unicode:   change font in .Xresources or .Xdefaults file and
"                   run : urxvt -fn 'xft:DejaVu Sans Mono for Powerline-11'
"                   for testing

if isdirectory(expand($VIMBUNDLE . "/vim-airline"))
    let g:airline#extensions#tabline#enabled = 1
    "let g:airline_theme             = 'powerlineish'
    let g:airline_theme             = 'badwolf'

    " Cygwin terminal
    if has ('win32unix') && !has('gui_running')
        let g:airline_powerline_fonts = 1
    endif

    "let g:bufferline_echo=0
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    "let g:airline_enable_branch     = 1
    "let g:airline_enable_syntastic  = 1
endif
"}

" Matchit"{
" -------

if isdirectory(expand($VIMBUNDLE . "/matchit.zip"))
    let b:match_ignorecase = 1
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

" Sessionman"{
" ----------

set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize

if isdirectory(expand($VIMBUNDLE . "/sessionman.vim"))
    nmap <leader>sl :SessionList<CR>
    nmap <leader>ss :SessionSave<CR>
    nmap <leader>sc :SessionClose<CR>
endif
"}

" Indent-guides"{
" -------------

if isdirectory(expand($VIMBUNDLE . "/vim-indent-guides"))
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
endif
"}

"}

" Writing"{
" -------


"}

" Completion"{
" =-=-=-=-=-

" Clang complete (C/C++ autocompletion)"{
" -------------------------------------

if has('unix')
    let g:clang_use_library=1
    let g:clang_hl_errors=1
    let g:clang_complete_copen=1
    let g:clang_periodic_quickfix=0
    autocmd Filetype c,cpp,cxx,h,hxx autocmd BufWritePre <buffer> :call g:ClangUpdateQuickFix()
endif
"}

" Omnicomplete"{
" ------------

" To disable omni complete, add the following to your .vimrc.before.local file:
"   let g:billinux_no_omni_complete = 1
if !exists('g:billinux_no_omni_complete')
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
            \if &omnifunc == "" |
            \setlocal omnifunc=syntaxcomplete#Complete |
            \endif
    endif

    hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
    hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
    hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    " Some convenient mappings
    inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " Automatically open and close the popup menu / preview window
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    set completeopt=menu,preview,longest
endif
"}

" YoucompleteMe or Neocomplete or Neocomplcache and Snippets"{
" ----------------------------------------------------------

" YouCompleteMe"{
" -------------

if count(g:billinux_bundle_groups, 'youcompleteme')
    let g:acp_enableAtStartup = 0

    " enable completion from tags
    let g:ycm_collect_identifiers_from_tags_files = 1

    " remap Ultisnips for compatibility for YCM
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.
    if !executable("ghcmod")
        autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    endif

    " For snippet_complete marker.
    if !exists("g:billinux_no_conceal")
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    endif

    " Disable the neosnippet preview candidate window
    " When enabled, there can be too much visual noise
    " especially when splits are used.
    set completeopt-=preview
endif
"}

" Neocomplete"{
" -----------


if count(g:billinux_bundle_groups, 'neocomplete')
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 15
    let g:neocomplete#force_overwrite_completefunc = 1


    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings
        " These two lines conflict with the default digraph mapping of <C-K>
        if !exists('g:billinux_no_neosnippet_expand')
            imap <C-k> <Plug>(neosnippet_expand_or_jump)
            smap <C-k> <Plug>(neosnippet_expand_or_jump)
        endif
        if exists('g:billinux_noninvasive_completion')
            iunmap <CR>
            " <ESC> takes you out of insert mode
            inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
            " <CR> accepts first, then sends the <CR>
            inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
            " <Down> and <Up> cycle like <Tab> and <S-Tab>
            inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
            " Jump up and down the list
            inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
        else
            " <C-k> Complete Snippet
            " <C-k> Jump to next snippet point
            imap <silent><expr><C-k> neosnippet#expandable() ?
                        \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                        \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
            smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

            inoremap <expr><C-g> neocomplete#undo_completion()
            inoremap <expr><C-l> neocomplete#complete_common_string()
            "inoremap <expr><CR> neocomplete#complete_common_string()

            " <CR>: close popup
            " <s-CR>: close popup and save indent.
            inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()"\<CR>" : "\<CR>"

            function! CleverCr()
                if pumvisible()
                    if neosnippet#expandable()
                        let exp = "\<Plug>(neosnippet_expand)"
                        return exp . neocomplete#smart_close_popup()
                    else
                        return neocomplete#smart_close_popup()
                    endif
                else
                    return "\<CR>"
                endif
            endfunction

            " <CR> close popup and save indent or expand snippet 
            imap <expr> <CR> CleverCr() 
            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y> neocomplete#smart_close_popup()
        endif
        " <TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        " Courtesy of Matteo Cavalleri

        function! CleverTab()
            if pumvisible()
                return "\<C-n>"
            endif 
            let substr = strpart(getline('.'), 0, col('.') - 1)
            let substr = matchstr(substr, '[^ \t]*$')
            if strlen(substr) == 0
                " nothing to match on empty string
                return "\<Tab>"
            else
                " existing text matching
                if neosnippet#expandable_or_jumpable()
                    return "\<Plug>(neosnippet_expand_or_jump)"
                else
                    return neocomplete#start_manual_complete()
                endif
            endif
        endfunction

        imap <expr> <Tab> CleverTab()


    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"}

" Neocomplcache"{
" ------------


elseif count(g:billinux_bundle_groups, 'neocomplcache')
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_enable_auto_delimiter = 1
    let g:neocomplcache_max_list = 15
    let g:neocomplcache_force_overwrite_completefunc = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'

    " Plugin key-mappings 
        " These two lines conflict with the default digraph mapping of <C-K>
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        if exists('g:billinux_noninvasive_completion')
            iunmap <CR>
            " <ESC> takes you out of insert mode
            inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
            " <CR> accepts first, then sends the <CR>
            inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
            " <Down> and <Up> cycle like <Tab> and <S-Tab>
            inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
            " Jump up and down the list
            inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
        else
            imap <silent><expr><C-k> neosnippet#expandable() ?
                        \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                        \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
            smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

            inoremap <expr><C-g> neocomplcache#undo_completion()
            inoremap <expr><C-l> neocomplcache#complete_common_string()
            "inoremap <expr><CR> neocomplcache#complete_common_string()

            function! CleverCr()
                if pumvisible()
                    if neosnippet#expandable()
                        let exp = "\<Plug>(neosnippet_expand)"
                        return exp . neocomplcache#close_popup()
                    else
                        return neocomplcache#close_popup()
                    endif
                else
                    return "\<CR>"
                endif
            endfunction

            " <CR> close popup and save indent or expand snippet 
            imap <expr> <CR> CleverCr()

            " <CR>: close popup
            " <s-CR>: close popup and save indent.
            inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
            "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y> neocomplcache#close_popup()
        endif
        " <TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"


    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
"}

" Normal Vim omni-completion"{
" --------------------------

" To disable omni complete, add the following to your .vimrc.before.local file:
"   let g:billinux_no_omni_complete = 1
elseif !exists('g:billinux_no_omni_complete')
    " Enable omni-completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

endif
"}

" Snippets"{
" --------

if count(g:billinux_bundle_groups, 'neocomplcache') ||
            \ count(g:billinux_bundle_groups, 'neocomplete')

    " Use honza's snippets.
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    " Enable neosnippet snipmate compatibility mode
    let g:neosnippet#enable_snipmate_compatibility = 1

    " For snippet_complete marker.
    if !exists("g:billinux_no_conceal")
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    endif

    " Enable neosnippets when using go
    let g:go_snippet_engine = "neosnippet"

    " Disable the neosnippet preview candidate window
    " When enabled, there can be too much visual noise
    " especially when splits are used.
    set completeopt-=preview
endif
"}

"}

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
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
"}

" Syntastic"{
" ---------

if isdirectory(expand($VIMBUNDLE . "/syntastic"))
    let g:syntastic_java_javac_config_file_enabled = 1
    let g:syntastic_always_populate_loc_list=1

    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

    map <leader>x :Errors<CR>
    map <leader>a :%!astyle --mode=c --style=ansi -s2 <CR><CR>
endif
"}


"}

" PHP"{
" =-=

" PIV"{
" ---

if isdirectory(expand($VIMBUNDLE . "/PIV"))
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
endif
"}

"}

" Ruby"{
" =-=-


"}

" Python"{
" =-=-=-

" PyMode
" ------

if !has('python')
    let g:pymode = 0
endif

if isdirectory(expand($VIMBUNDLE . "/python-mode"))
    let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
endif

"}

" Javascript"{
" =-=-=-=-=-

" JSON"{
" -----

nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
let g:vim_json_syntax_conceal = 0
"}


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
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
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

" Thematic"{
" --------

if isdirectory(expand($VIMBUNDLE . "/vim-thematic"))
    " All themes are defines here
    let g:thematic#themes = {
    \ 'molokai' :   {'colorscheme': 'molokai',
    \                'airline-theme': 'molokai'
    \               },
    \
    \ 'solarized' : {'colorscheme': 'solarized',
    \                'airline-theme': 'solarized'
    \               },
    \ }

    " Default values to be shared by all defined themes
    let g:thematic#defaults = {
    \ 'background': 'dark',
    \ 'laststatus': 2,
    \ }

    " Additional options for GUI
    let g:thematic#themes ={
    \ 'molokai' :   {'typeface': 'Source Code Pro Light',
    \                'font-size': 12
    \               }
    \ }

    " Setting an initial theme
    let g:thematic#theme_name = 'molokai'

    " Themes keymap
    nnoremap <leader>S :Thematic solarized<CR>
    nnoremap <leader>M :Thematic molokai<CR>

else

    " In your .vimrc.before.local file
    " list only the color groups you will use
    if !exists('g:billinux_color_groups')
        let g:billinux_color_groups=['molokai', 'solarized',]
    endif


    if count(g:billinux_color_groups, 'molokai')
        if isdirectory(expand($VIMBUNDLE . "/molokai"))
            let g:molokai_original = 1
            colorscheme molokai
        endif
    endif

    if count(g:billinux_color_groups, 'solarized')
        if isdirectory(expand($VIMBUNDLE . "/vim-colors-solarized"))
            let g:solarized_termcolors=256
            let g:solarized_termtrans=1
            let g:solarized_contrast="normal"
            let g:solarized_visibility="normal"
            colorscheme solarized
        endif
    endif

endif
"}

"}

" Misc"{
" =-=-

" Markdown"{
" --------

if isdirectory(expand($VIMBUNDLE . "/vim-markdown"))
endif
"}

" Ctags"{
" -----
set tags=./tags;/,~/.vimtags

" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif
"}

"}

"}

" GUI SETTING"{
" ===========

if has('gui_running')
    set antialias
    set lines=40

    " GVim options to make it like Vim
    set guioptions+=c
    set guioptions+=R
    set guioptions-=m
    set guioptions-=r           " Kill right scrollbar
    set guioptions-=b           " Kill right scrollbar
    set guioptions-=T           " Kill toolbar
    set guioptions-=R
    set guioptions-=L           " Kill left scrollbar multiple buffers
    set guioptions-=e           " Kill left scrollbar multiple buffers

    " Font to run vim-airline (cf.: vim-airline config.
    if has('unix') || has('win32unix')
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
        set guifont=Powerline\ Consolas\ 11
    elseif has('macunix')
        set guifont=Powerline\ Consolas\ 11
        "set guifont=Menlo\ Regular\ for\ Powerline:h15
        "set guifont=Droid\ Sans\ Mono\ for \Powerline:h14
        "set guifont=Meslo\ LG\ for\ Powerline:h11
    elseif has('win16') || has('win32') || has('win64')
        set guifont=Powerline_Consolas:h11:cANSI
    endif

elseif $TERM =~ '^xterm*' || $TERM =~ '^rxvt*' || $TERM =~ '^screen' ||  $COLORTERM == 'gnome-terminal'
    set t_Co=256
elseif isdirectory(expand($VIMBUNDLE . "/csapprox"))
    " To avoid CSApprox workarounds in console
    " disable CSApprox
    let g:CSApprox_loaded=1
endif

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

function! MakeViewCheck()"{
    if has('quickfix') && &buftype =~ 'nofile' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif
    if empty(glob(expand('%:p'))) | return 0 | endif
    if &modifiable == 0 | return 0 | endif
    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

    let file_name = expand('%:p')
    for ifiles in g:skipview_files
        if file_name =~ ifiles
            return 0
        endif
    endfor

    return 1
endfunction
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

