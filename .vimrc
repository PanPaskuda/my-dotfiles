
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" VIMRC_INFO:
" use zM - to open all folds
" use zR - to close all folds
" use za - to toggle actual fold
" use <leader>vs to sorce vimrc again


" TABLE_OF_CONTENTS:
" + VUNDLE_PLUGIN_MANAGER
" + AUTO_CMD
" + GENERAL_SETTINGS
" PLUGINS_AND_FUNCTIONS:

" + CLEAN_VIEW function
" + CSCOPE
" + CCTREE
" + YOU_COMPLETE_ME
" + MULTIPLE_CURSORS
" + GIT_GUTTER
" + QUICK_FIX_WINDOW
" + ACK
" + SURROUND
" + INDENT_GUIDE
" + UNDO_TREE
" + VIM_DIFF_TOGGLE
" + SPLIT_TOGGLE
" + TAB_SPACES_TOGGLE
" + DRAG_VISUALS
" + COLOR_SCHEME
" + CTRL_P
" + SILVER_SERCHER
" + EASY_MOTION
" + CTRL_SF
" + VIM_DEVICONS

" SHORT_KEYS_MAPPING:
" + ARROW_KEYS
" + F1_F12
" + GENERAL_MAPPING
" + OPERATOR_PENDING
" + EASY_MOTION
" + CTRL_SF
" + DELIMIT_MATE
" + MARK_KARKAT
" + CSCOPE
" + YOU_COMPLETE_ME
" + MULTIPLE_CURSORS
" + DRAG_VISUALS
" + TABS

"=============================================================
"    TODO
"=============================================================
"  +  terminal view
"  +  preproc view
"  +  description of content + real hyperlinks
"  +  maps for copen cclose cwindow etc...
"  +  create a function to create a full config: CD, YCM, tags
"=============================================================
"=              VUNDLE_PLUGIN_MANAGER                    = {{{
"=============================================================
"HELP: How to install vudle:
"   set up Vundle:
"       git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"HELP: to install all plugins run:
"   :BundleUpdate
"because of Vundle
set nocompatible
set langmenu=en "set menu to English - must be called before menu is loaded
filetype off " required

set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

"call vundle#rc()

" Let Vundle manage Vundle
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'
"My Bundles:
Plugin 'mileszs/ack.vim' "grep alternative used with silversearcher
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
if has("win32")
    "NOTE: issue on windows?
else
    Plugin 'airblade/vim-gitgutter'
endif
Plugin 'vim-airline/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mbbill/undotree'
Plugin 'altercation/vim-colors-solarized'
"ADD: Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
"TODO old ctrlP Plugin 'vim-scripts/Command-T'
"TODO new ctrlP to check Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'vim-scripts/The-NERD-tree'
"Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/snipMate'
Plugin 'vim-scripts/Mark--Karkat'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
Plugin 'Raimondi/delimitMate' "provides automatic closing of quotes, parenthesis, brackets, etc.
Plugin 'dyng/ctrlsf.vim' "An ack powered code search and view tool lets you edit file in-place
Plugin 'hari-rangarajan/CCTree' "generate call tree graph
"DevIcons has to be load as he very last plugin
Plugin 'ryanoasis/vim-devicons'

call vundle#end()
"}}}

syntax on "syntax highlighting
set background=dark




"===========================================================
"=                         AUTO_CMD                      = {{{
"===========================================================
augroup vimrcAutocmds
    "Remove ALL autocommands for the current group
    autocmd!
    "to jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    "if cursor doesn't move, check whether the current file is up to date
    autocmd CursorHold * checktime
    "treat *.cog files as "c" files
    autocmd BufRead,BufNewFile *.cog setfiletype c
    autocmd BufRead,BufNewFile *.h setfiletype c
    autocmd BufRead,BufNewFile *.h set syntax=c.doxygen
    autocmd FileType c          set syntax=c.doxygen
    autocmd FileType python     nnoremap <buffer> <localleader>/ I#<ESC>
    autocmd FileType c          nnoremap <buffer> <localleader>/ I//<ESC>
    autocmd FileType vim        nnoremap <buffer> <localleader>/ I"<ESC>
    autocmd FileType sh         nnoremap <buffer> <localleader>/ I#<ESC>
   "local marker for folding 3x"{"
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"

filetype plugin indent on
filetype plugin on


"===========================================================
"=                   GENERAL_SETTINGS                  = {{{
"===========================================================
set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set autowrite   " Automatically save before commands like :next and :make
set hidden     " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)
set hlsearch    "highlight all search results
set incsearch   " highlight find results during writing /fin...
set textwidth=100
set colorcolumn=+1
set wildmenu "pres 'wildchar' (usually <Tab>) to invoke completion,
set autoread "automatically read changed file again.
"set ruler TODO to delete
set cmdheight=2 " Height of the command bar
set updatetime=100 "100ms time of upadating i.e. gitgutter signs
set nrformats-=octal
set clipboard+=unnamed "yank and paste from clipboard as a default (use y instead of "*y ).
set guioptions=aegimrLtc "default + 'c' to block gui popups, - 'T' to disable toolbar
set spl=en spell "set spell checking to English
set expandtab "remove tab to spaces
set tabstop=4 "tab set to 4 spaces
set shiftwidth=4 "4 space for (auto)indent.
set shiftround "roun indent to multiple of 'shiftwidth'
set backspace=indent,eol,start "make backspace work like most other programs
set rnu "show relative line number
set number "show current line number
set nobackup "disable creation backup files
set noswapfile "disable creation swap files
set whichwrap=<,>,h,l "wrap to next lines for arrows and h,l
set visualbell "make a short visual flash instead of an error beep
set lazyredraw " Don't redraw while executing macros (good performance config)
set t_Co=256 "set terminal vim to 256 colors

" set path+=** TODO check how it works

let mapleader=","
let maplocalleader=","

"following special code to ommit gnome terminal restrictions for ALT button
"let g:enable_on=1

"if g:enable_on
"    let c='a'
"    while c <= 'z'
"        exec "set <A-".c.">=\e".c
"        exec "imap \e".c." <A-".c.">"
"        let c = nr2char(1+char2nr(c))
"    endw
"endif

"set timeout ttimeoutlen=50
if has("win32")
    "set backupdir=$VIM\backup
    "set directory=$VIM\tmp
else
    "set backupdir=~/.vim/backup
"TODO how to swoitch off swap files    set directory=~/.vim/swap
endif
"}}}

"===========================================================
"=                   CREATE_WORKSPACE                  = {{{
"===========================================================
function! CreateWorkspace()
"TODO:
"1. Create session file
"2. Set path
"3. Index ctags with ignored directories
"4. Index ctrl_p with ignored directories
"5. Prepare flags for YCM

endfunction
"}}}

"===========================================================
"=                     CLEAN_VIEW                        = {{{
"===========================================================
function! CleanViewEnable()
    set nospell
    if exists('g:loaded_indent_guides')
        IndentGuidesDisable
    endif
    set list listchars=tab:>-
    set nocursorline
    set nornu
    let g:clean_view_on =0
endfunction

function! CleanViewDisable()
    set spell
    if exists('g:loaded_indent_guides')
        IndentGuidesEnable
    endif
    set list listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:o,space:·
    set cursorline
    set rnu
    let g:clean_view_on =1
endfunction

if has ("gui_running")
    call CleanViewDisable()
else
    call CleanViewEnable()
endif

function! CleanViewToggle()
    echo "toggle CleanView"
    if bufwinnr(1)
        if(g:clean_view_on ==0)
            call CleanViewDisable()
        else
            call CleanViewEnable()
        endif
    endif
endfunction
"}}}


"===========================================================
"=                         CSCOPE                        = {{{
"===========================================================
if has("cscope")
    if has("win32")
        set rtp +=C:\tools\cscope
        set cscopeprg=C:\tools\cscope\cscope.exe
    else
        set cscopeprg=/usr/bin/cscope
    endif

    set cscopetagorder=1 "set to 1 to search ctags DBs first
    set cscopetag "cst map CTRL-] to cscope; ncst - map CTRL-] as default tag search
    set nocscopeverbose
    "add any database in current directory
    if filereadable("cscope.out")
        cscope add cscope.out
    "else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cscope add $CSCOPE_DB
    endif
set cscopeverbose
endif

function! CreateCscopeDatabase()
    echo "create database"
    if has("win32")
        :!dir /b /s *.c > cscope.files
        :!dir /b /s *.h >> cscope.files
        :!dir /b /s *.mk >> cscope.files
        :silent! cscope kill 0
        :!cscope -b -i cscope.files -f cscope.out
        :!del /Q cscope.files
        :cscope add cscope.out
        "loading database into CCTree takes way to long time
"        :CCTreeCscopeDb cscope.out
    else
        :!find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > cscope.files
        :!cscope -b -i cscope.files -f cscope.out
        :!rm cscope.files
        :silent! cscope kill 0
        :cscope add cscope.out
        "loading database into CCTree takes way to long time
"        :CCTreeCscopeDb cscope.out
    endif
endfunction
"}}}


"===========================================================
"=                         CCTREE                        = {{{
"===========================================================
"HELP:You can download the latest release of the script from this url :
"   http://www.vim.org/scripts/script.php?script_id=2368
"   Copy this file to ~/.vim/plugins/
let g:CCTreeCscopeDb = "cscope.out"
let g:CCTreeRecursiveDepth = 3
let g:CCTreeMinVisibleDepth = 3
let g:CCTreeOrientation = "leftabove"
let g:CCTreeWindowVertical = 1
let g:CCTreeWindowHeight = -1
let g:CCTreeWindowMinWidth = 40
let g:CCTreeDisplayMode = 1
"}}}


"=============================================================
"=                      YOU_COMPLETE_ME                  = {{{
"=============================================================
"NOTE: to recompile YCM:
"       cd ~/.vim/bundle/YouCompleteMe
"       python3 install.py --clang-completer
set encoding=utf-8 "encoding is necessarily for YouCompleteMe
set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_max_diagnostics_to_display = 200
"append an option to clang binary
let g:ycm_clangd_args = ["-Wextra"]
"}}}


"=============================================================
"=                    MULTIPLE_CURSORS                   = {{{
"=============================================================
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1
"}}}


"=============================================================
"=                      GIT_GUTTER                       = {{{
"=============================================================
let g:gitgutter_max_signs = 500  "500 is a default value
"    jump to next hunk (change): ]c
"    jump to previous hunk (change): [c.
"    preview the hunk with <Leader>hp
"    stage the hunk with <Leader>hs
"    undo it with <Leader>hu
"NOTE: in visual and operator-pending modes
"    ic operates on all lines in the current hunk.
"    ac operates on all lines in the current hunk and any trailing empty lines.

"Use the GitGutterFold command to fold all unchanged lines, leaving just the hunks visible. Use zr to unfold 3 lines of context above and below a hunk.
"Execute GitGutterFold a second time to restore the previous view.
"}}}


"=============================================================
"=                   QUICK_FIX_WINDOW                    = {{{
"=============================================================
"NOTE: used by ACK and YCM
nnoremap <leader>cc :call QuickfixToggle()<CR>
nnoremap <leader>cn :cnext
nnoremap <leader>cp :cprevious

let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
"}}}


"=============================================================
"=                         ACK                           = {{{
"=============================================================
let g:ackhighlight = 1 "highlight the searched term
let g:ack_autofold_results = 0 " 1= fold the results in quickfix by file name
let g:ackprg = 'ag --nogroup --nocolor --column' "to use silversearecher-ag instead of ack
"the same effect but will report every match on the line.
"let g:ackprg = 'ag --vimgrep'
nnoremap <Leader>fa :Ack! -Q '<cword>'<CR>
nnoremap <Leader>fA :execute "Ack! -Q " . shellescape(expand("<cWORD>")) <CR>
vnoremap <Leader>fa :<C-U>Ack! -Q shellescape(@*) <CR>

"map <Leader>fa exe 'cexpr system("grep -rn --include=\"*.[ch]\" '.expand('<cword>').' . ")'<CR>
"map <Leader>fa :!grep -rn --include="*.[ch]" <cword> .<CR>
"default mappings:
" ?      display a quick summary of these mappings.
" o      open file (same as Enter).
" O      open file and close the quickfix window.
" go     preview file (open but maintain focus on ack.vim results).
" t      open in a new tab.
" T      open in new tab without moving to it.
" h      open in horizontal split.
" H      open in horizontal split, keeping focus on the results.
" v      open in vertical split.
" gv     open in vertical split, keeping focus on the results.
" q      close the quickfix window.

if has("win32")
    set rtp +=c:\tools\grep\
else
    "TODO linux
endif
"}}}


"=============================================================
"=                      SURROUND                         = {{{
"=============================================================
"options: ds, cs, cS, ys, yS, yss, ySs, ySS
" cs"'    to change surrounding " to '
" ds" To remove the delimiters entirely
" cst" To go full circle
"ysiw] to surround inner word
" cs]{ to change braces to square braces and add some space (use } instead of { for no space): cs]{
" yssb or yss) to wrap the entire line in parentheses
"}}}


"=============================================================
"=                    INDENT_GUIDES                      = {{{
"=============================================================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_space_guides = 1
let g:indent_guides_tab_guides = 1
"nmap <silent><unique> <Leader>ig <Plug>IndentGuidesToggle
"}}}


"=============================================================
"=                       UNDO_TREE                       = {{{
"=============================================================
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
"}}}


"=============================================================
"=                   VIM_DIFF_TOGGLE                     = {{{
"=============================================================
let g:vim_diff_on=0

function! VimDiffToggle()
    if bufwinnr(1)
        if(g:vim_diff_on==0)
            :silent windo diffthis
            let g:vim_diff_on=1
        else
            :silent windo diffoff
            let g:vim_diff_on=0
        endif
    endif
endfunction
"}}}


"=============================================================
"=                     SPLIT_TOGGLE                      = {{{
"=============================================================
let g:vertical_toggle=0

function! SplitToggle()
  if bufwinnr(1)
    if(g:vertical_toggle==0)
      nnoremap + <C-W>+
      nnoremap - <C-W>-
      let g:vertical_toggle=1
      echo 'Horizontal split resizing ON'
   else
      nnoremap + <C-W>>
      map - <C-W><
      let g:vertical_toggle=0
      echo 'Vertical split resizing ON'
   endif
 endif
endfunction
"}}}


"=============================================================
"=                  TAB_SPACES_TOGGLE                    = {{{
"=============================================================
let g:spaces_indenting=1
let g:linux_kernel_tabs=0

function! TabsSpacesToggle()
    if(bufwinnr(1))
        if(g:spaces_indenting==0)
            if(g:linux_kernel_tabs==0)
                set noexpandtab
                set copyindent
                set preserveindent
                set softtabstop=0
                set shiftwidth=4
                set tabstop=4
                let g:linux_kernel_tabs=1
                echo 'TABS INDENTING ON'
            else
                set tabstop=8
                set shiftwidth=8
                set softtabstop=8
                set noexpandtab
                let g:linux_kernel_tabs=0
                let g:spaces_indenting=1
                echo 'LINUX KERNEL INDENTING ON'
            endif
        else
            set expandtab
            set shiftwidth=4
            set softtabstop=4
            let g:spaces_indenting=0
            echo 'SPACES INDENTING ON'
        endif
    endif
endfunction
"}}}


"=============================================================
"=                     DRAG_VISUALS                      = {{{
"=============================================================
runtime plugin/dragvisuals.vim
" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1



"TODO: =>

let NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden=1

let EasyGrepModeUser=1 "user group of files - I set group inside plugin
"to "*.c *.h"
let g:EasyGrepRecursive=1 "recursive search, started from main folder
"pecifies that multiple matches on the same line be treated as
"different matches
let g:EasyGrepEveryMatch=1
let g:EasyGrepFileAssociationsInExplorer=1 "allowed to set group of
"files in vim by GrepOption
"}}}


"=============================================================
"=                      COLOR_SCHEME                     = {{{
"=============================================================
set background=dark
    colorscheme solarized
	"WHITESPACE_TEST    

highlight NERDTreeDir guibg=#002b36 guifg=#268bd2

"tabs and trailing spaces (ignore ^\t ):
"match ExtraWhitespace /[^\t^][\t]\|\s\+$\| \+\ze\t/
"tabs and trailing spaces:
highlight ExtraWhitespace ctermfg=white ctermbg=red guifg=white guibg=red
match ExtraWhitespace /[\t]\|\s\+$\| \+\ze\t/
highlight ExtraWhitespace ctermfg=white ctermbg=red guifg=white guibg=red

"NOTE: weird bahaviour after settings a guifont: resize of the gvim window
"set font for GUI VIM: 0Oo !|1lIiL g9q
if has("win32")
    set guifont=Consolas:h11
else
    set guifont=Ubuntu\ Mono\ 11
endif





" TagList options
let Tlist_Close_On_Select = 1 "close taglist window once we selected
"something
let Tlist_Exit_OnlyWindow = 1 "if taglist window is the only window
"left, exit vim
let Tlist_Show_One_File = 1 "show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1 "automatically switch to taglist
"window
let Tlist_Highlight_Tag_On_BufEnter = 1 "highlight current tag in
"taglist window
let Tlist_Process_File_Always = 1 "even without taglist window, create
"tags file, required for displaying tag in statusline
let Tlist_Use_Right_Window = 1 "display taglist window on the right
let Tlist_Display_Prototype = 1 "display full prototype instead of
"just function name

"todo the ctags command generated right now tags for definition and
"declaration this shall be changed to the definition only or give some
"possibility of choice for the user
"TODO to delete:
function! CreateTags()
    if has("win32")
        :!c:\tools\ctags58\ctags.exe -R --c++-kinds=+p --fields=+liaS --extra=+q <CR><CR>
        ":!rm ./tags; /usr/bin/ctags -R --c++-kinds=+p --fields=+liaS --extra=+q <CR><CR>
        ":silent !ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .
    else
        :silent !/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .
    endif
    :redraw!
endfunction
"let Tlist_Ctags_Cmds="C:\Program Files (x86)\ctags58"
"let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_WinWidth = 70

"OmniCppComplete
set ofu=syntaxcomplete#Complete
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0
let OmniCpp_ShowAccess          = 1
let OmniCpp_SelectFirstItem     = 1
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files set to 2
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e.  parameters) in popup window
"format of popup menu
set completeopt=menuone,menu,longest

filetype plugin indent on

function! StringTrailingWhiteSpace()
    " store current possition
    let l = line(".")
    let c = col(".")

    "if getline(".")[col(".")-1] == ' '

    call cursor(l,c-1)
    while getline(".")[col(".")-1] == ' '
        execute "normal x"
        let c = c - 1
        call cursor(l,c-1)
    endwhile

    call cursor(l,c)

endfunction
"}}}


"=============================================================
"=                        CTRL_P                         = {{{
"=============================================================
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'rw' "begin finding a root from the current working directory
let g:ctrlp_max_height = 20 " Set the maximum height of the match window:
let g:ctrlp_regexp = 0 "Set this to 1 to set regexp search as the default: toggle: <c-r>
let g:ctrlp_by_filename = 0 "set searching by filename (as opposed to full path) toggle <c-d>
let g:ctrlp_mruf_relative = 1 "show only MRU files in the current working directory
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.|_).*$',
    \ 'file': '\v\.(exe|so|dll|html|out|log|tmp|out|tex|js|xls|png|gif|dot|svg|map|md5|xml||obj|o|d|lock|hex|cxm|yml|)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
    "\ 'dir':  '\v[\/]\.(git|hg|svn)$',

"find visualy selected file or path name using CTRL_P
vnoremap <C-P> <ESC><Plug>(ctrlp)<C-\>r*
noremap <C-P> :CtrlP<CR>
"NOTE:
"<C-UP> / <C-DOWN> to switch buff / MRU / files
"<F5> inside CtrlP to refresh cache
"<C-D> toggle between path/file search
"<C-R> toggle between regexp/normal search
"}}}


"=============================================================
"=                    SILVER_SERCHER                     = {{{
"=============================================================
"let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}


"=============================================================
"=                     EASY_MOTION                       = {{{
"=============================================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case insensitive feature
"}}}


"=============================================================
"=                        CTRL_SF                        = {{{
"=============================================================
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_search_mode = 'async'
"let g:ctrlsf_default_view_mode = 'compact'
"let g:ctrlsf_populate_qflist = 1
"let g:ctrlsf_regex_pattern = 1
"let g:ctrlsf_position = 'bottom'
"let g:ctrlsf_winsize = '30%' "use % or absolute value i.e 30% or 100
let g:ctrlsf_extra_backend_args = {
    \ 'ag': '--file-search-regex ".*\.(c|h|cpp|hpp|txt)$"'
    \ }
"}}}


"=============================================================
"=                     DELIMIT_MATE                      = {{{
"=============================================================
let delimitMate_expand_cr = 1 "This option turns on/off the expansion of <CR>.
let delimitMate_expand_space = 1 "This option turns on/off the expansion of <Space>.
"}}}


"=============================================================
"=                     VIM_DEVICONS                      = {{{
"=============================================================
let g:airline_powerline_fonts = 1 "
"}}}

"=============================================================
"=                  SHORT_KEYS_MAPPING                       =
"=============================================================
"=                    ARROW_KEYS                         = {{{
"
"NOTE: can by added by plugin: wikitopian/hardmode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"}}}

"=                      F1_F12                           = {{{
"nmap <F1> :%bd|e#<CR><CR>
noremap <F1> :%bd<CR><CR>
noremap <F2> :UndotreeToggle<CR>
noremap <F3> :TlistToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
noremap <F4> :NERDTreeToggle<CR>
noremap <F5> :call CleanViewToggle()<CR>
noremap <F6> :set cursorline!<CR>
noremap <silent> <F7> :<C-U>call StringTrailingWhiteSpace()<CR>
noremap <silent> <F8> :<C-U>call TabsSpacesToggle()<CR>
noremap <silent> <F8> :<C-U>call TabsSpacesToggle()<CR>
noremap <silent> <F9> :<C-U>call VimDiffToggle()<CR>
noremap <silent> <F10> :<C-U>call SplitToggle()<CR>
noremap <S-F11> :make clean<CR> :!bear make <CR> :YcmRestartServer <CR>
noremap <F11> :YcmForceCompileAndDiagnostics<CR>:YcmDiag<CR>
"map <F12> :call CreateTags()<CR>
noremap <silent><F12> :call CreateCscopeDatabase()<CR>
"TODO add an script to noremap <silent><S-F12> :call CreateBearYcmCscope()<CR>
"}}}


"=                      GENERAL_MAPPING                  = {{{
"
"put enter and strip in previous line all spaces till the nearest non space
nnoremap <S-K> :call StringTrailingWhiteSpace()<CR>i<CR><ESC>
"nnoremap <C-K> :call StringTrailingWhiteSpace()<CR>DkA<CR><ESC>p
nnoremap <CR> A<CR><ESC>
nnoremap <S-CR> kA<CR><ESC>
"alternative saves
nnoremap <leader>w :write<CR>
command! W w
"highlight a word but do not jump:
nnoremap <silent> # "syiW<Esc>: let @/ = @s<CR>
nnoremap <silent> * "syiw<Esc>: let @/ = @s<CR>
"center a view at the search occurrence
nnoremap n nzz
nnoremap N Nzz
"search using the 'verymagic' option
nnoremap / /\v
nnoremap ? ?\v
"enable/disable spell checking
nnoremap <leader>s z=
" Ctrl S to help with search and replace in whole file
nnoremap <C-S> y:<C-U>%s/<C-R>///gc<Left><Left><Left>
" Ctrl S to help with search and replace in the marked region
vnoremap <C-S> :s/<C-R>///gc<Left><Left><Left>

"let <C-U> and <C-W> be able to undo
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
"open vimrc
nnoremap <leader>vo :tabnew $MYVIMRC<CR> "source vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>
"escape from the insert mode by jk
inoremap jk <ESC>
"show content of all register
nnoremap <silent> "" :registers<CR>
"open in vsplit last buffer
nnoremap <leader>,bb :execute "rightbelow vsplit " . bufname("#")<CR>
"jump to help:
nnoremap <leader>vh :execute "help " . shellescape(expand("<cWORD>")) <cr>
"}}}


"=                OPERATOR_PENDING                       = {{{
"TODO: LVTHW chapter 15
onoremap p i(
onoremap q i"
onoremap s i[
"use cim to change word inside underscores
onoremap im :<c-u>normal! T_vt_<cr>
" use cam to change an undescored word
onoremap am :<c-u>normal! F_vf_<cr>
" use cm to change (ie: word) till next underscore
onoremap m t_
" use cM to change (ie: word) till next underscore
onoremap M T_
nnoremap m f_
nnoremap M F_

"TODO: map a operator pending to go to nextof space, undersore, minus or next CapitalLetter (but
"only when a small letter is at the coursor)
"}}}


"=                     EASY_MOTION                       = {{{
" Jump to anywhere you want with minimal keystrokes, with just one key binding:   `s{char}{label}`
nnoremap <space> <Plug>(easymotion-overwin-f)
" or  `s{char}{char}{label}`   Need one more keystroke, but on average, it may be more comfortable.
nnoremap <leader><space> <Plug>(easymotion-overwin-f2)

nnoremap <Leader>w <Plug>(easymotion-w)
nnoremap <Leader>W <Plug>(easymotion-W)
nnoremap <Leader>b <Plug>(easymotion-b)
nnoremap <Leader>B <Plug>(easymotion-B)
nnoremap <Leader>e <Plug>(easymotion-e)
nnoremap <Leader>E <Plug>(easymotion-E)
nnoremap <Leader>ge <Plug>(easymotion-ge)
nnoremap <Leader>gE <Plug>(easymotion-gE)
nnoremap <Leader>j <Plug>(easymotion-j)
nnoremap <Leader>k <Plug>(easymotion-k)
"nnoremap <Leader>n <Plug>(easymotion-bd-n)
"nnoremap <Leader>N <Plug>(easymotion-N)
"nnoremap <Leader>s <Plug>(easymotion-s)
"}}}


"=                       CTRL_SF                         = {{{
"most hotkeys can not be 'noremap':
"execute cword/cWORD/VSELECT search:
nmap <C-F>a <Plug>CtrlSFCwordPath <CR>
nmap <C-F><C-A> :execute "CtrlSF " . shellescape(expand("<cWORD>")) <CR>
vmap <C-F>a <Plug>CtrlSFVwordExec

"start prompting only
nmap <C-F> <Plug>CtrlSFPrompt
vmap <C-F> <Plug>CtrlSFVwordPath

"find a previous search pattern TODO: delete \v (verymagic sign) from search
nmap <C-F>/ <Plug>CtrlSFPwordPath

"Open/close CtrlSF window
nnoremap <C-F><C-F> :CtrlSFToggle<CR>
inoremap <C-F><C-F> <Esc>:CtrlSFToggle<CR>
"nnoremap <C-F>o :CtrlSFOpen<CR>
"}}}


"=                    MARK_KARKAT                        = {{{
"NOTE: default mappings from plugin:
"nnoremap <Leader>m <Plug>MarkSet
"vnoremap <Leader>m <Plug>MarkSet
"nnoremap <Leader>r <Plug>MarkRegex
"vnoremap <Leader>r <Plug>MarkRegex
"nnoremap <Leader>n <Plug>MarkClear
"nnoremap <Leader>* <Plug>MarkSearchCurrentNext
"nnoremap <Leader># <Plug>MarkSearchCurrentPrev
"nnoremap * <Plug>MarkSearchNext
"nnoremap # <Plug>MarkSearchPrev
"" No default mapping for <Plug>MarkAllClear
"" No default mapping for <Plug>MarkToggle

"NOTE: mapping is to avoid error from plugin
nnoremap <Leader>NNNNNNCN <Plug>MarkSearchCurrentNext
nnoremap <Leader>NNNNNNCP <Plug>MarkSearchCurrentPrev
nnoremap <Leader>NNNNNNC <Plug>MarkClear
nnoremap <Leader>NNNNNNN <Plug>MarkSearchNext
nnoremap <Leader>NNNNNNP <Plug>MarkSearchPrev

"NOTE: custom mapping
nnoremap <Leader>n <Plug>MarkToggle
nnoremap <Leader>nt <Plug>MarkToggle
nnoremap <Leader>* <Plug>MarkSearchAnyNext
nnoremap <Leader># <Plug>MarkSearchAnyPrev
""}}}

"=                       CSCOPE                          = {{{
" find callers:
noremap <Leader>fc :cscope f c <cword><CR>
" find callees:
noremap <Leader>fd :cscope f d <cword><CR>
" find definition:
noremap <Leader>fg :cscope f g <cword><CR>
" find file:
noremap <Leader>ff :cscope f f <cword><CR>
" find files including this:
noremap <Leader>fi :cscope f i %:t<CR>
" find symbol:
noremap <Leader>fs :cscope f s <cword><CR>
" find text:
noremap <Leader>ft :cscope f t <cword><CR>
" grep this:
noremap <Leader>fe :cscope f e <cword><CR>


"use 'v' or 's' to open in new split or vertical window
nnoremap <Leader>fvs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fvg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fvc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fvt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fvf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <Leader>fvi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <Leader>fvd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fva :vert scs find a <C-R>=expand("<cword>")<CR><CR>

nnoremap <Leader>fss :scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fsg :scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fsc :scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fst :scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fse :scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fsf :scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <Leader>fsi :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <Leader>fsd :scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>fsa :scs find a <C-R>=expand("<cword>")<CR><CR>
"}}}


"=                    YOU_COMPLETE_ME                    = {{{
nnoremap <Leader>yy :YcmCompleter<CR>
"jump back
nnoremap <leader>jb <C-O>
"jump forward
nnoremap <leader>jf <C-I>

"DefinitionElseDeclaration<CR>
nnoremap <silent> <leader> yg :YcmCompleter GoTo <CR>
nnoremap <silent> <Leader>i :TlistToggle<CR>
nnoremap <silent> <Leader>j :NextError<CR>
nnoremap <silent> <Leader>k :PrevError<CR>
"nnoremap <silent> <Leader>h :OlderError<CR>
"nnoremap <silent> <Leader>l :NewerError<CR>
nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>yr :YcmRestartServer<CR>
nnoremap <silent> <Leader>yc :YcmForceCompileAndDiagnostics<CR>
nnoremap <silent> <Leader>yd :YcmDiag<CR>
nnoremap <silent> <Leader>ys :YcmShowDetailedDiagnostic<CR>
nnoremap <silent> <Leader>yn :YcmCompleter<CR>
nnoremap <silent> <Leader>yi :YcmDebugInfo<CR>

" find callers:
noremap <Leader>yc :YcmCompleter GoTo<CR>
" find callees:
noremap <Leader>yd :YcmCompleter GoToDefinition<CR>
" find definition:
noremap <Leader>yg :YcmCompleter GoToDeclaration<CR>
" find file:
noremap <Leader>yf :YcmCompleter GoToInclude<CR>
" find symbol:
noremap <Leader>yt :YcmCompleter GetType<CR>
" find text:
noremap <Leader>yp :YcmCompleter GetParent<CR>
" grep this:
noremap <Leader>yx :YcmCompleter GetDoc<CR>

"TODO maps subcommand
"GoToImprecise
"GoTo
"GoToDefinition
"GoToDeclaration
"GoToInclude
"
"TODO maps subcommand
"GetType
"GetTypeImprecise
"GetParent
"GetDoc
"GetDocImprecise
"
"}}}


"=                         CCTREE                        = {{{
"TODO cctree not works and set custom shortcuts
let g:CCTreeKeyTraceForwardTree = '<C-\>>'
let g:CCTreeKeyTraceReverseTree = '<C-\><'
let g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting
let g:CCTreeKeySaveWindow = '<C-\>y'
let g:CCTreeKeyToggleWindow = '<C-\>w'
let g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree
let g:CCTreeKeyDepthPlus = '<C-\>='
let g:CCTreeKeyDepthMinus = '<C-\>-'
"}}}


"=                    MULTIPLE_CURSORS                   = {{{
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
"}}}


"=                     DRAG_VISUALS                      = {{{
vnoremap  <expr>  <LEFT>   DVB_Drag('left')
vnoremap  <expr>  <RIGHT>  DVB_Drag('right')
vnoremap  <expr>  <DOWN>   DVB_Drag('down')
vnoremap  <expr>  <UP>     DVB_Drag('up')
vnoremap  <expr>  D        DVB_Duplicate()

vnoremap  <expr>  <S-LEFT>   DVB_Drag('left')
vnoremap  <expr>  <S-RIGHT>  DVB_Drag('right')
vnoremap  <expr>  <S-DOWN>   DVB_Drag('down')
vnoremap  <expr>  <S-UP>     DVB_Drag('up')
"}}}


"=                         TABS                          = {{{
"create new tab
nnoremap <leader>tn :tabnew<CR>
"close tab
nnoremap <leader>tc :tabclose<CR>
"move tab
nnoremap <leader>tm :tabmove<CR>
"first tab
nnoremap <leader>tf :tabfirst<CR>
"previous tab
nnoremap <leader>h :tabfirst<CR>
nnoremap <leader>th :tabfirst<CR>
"next tab
nnoremap <leader>l :tabNext<CR>
nnoremap <leader>tl :tabNext<CR>
"}}}


"=               TO MOVE OR  DELETE                      = {{{
"shift lines using alt+jk (in all modes)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"sugestion for autocompletion C/C++ word
inoremap <leader>c <C-x><C-o>

"coment-out
nnoremap <leader>o 'aO#if 0<ESC>'zo#endif<ESC>0

"delete sign - like 'x' in normal mode
inoremap <A-x> <del>
cnoremap <A-x> <del>

"close all
noremap <C-q> :qall<CR>

"actions for window: resize, equal, navigate
nnoremap <C-=> <C-w>=
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-0> <C-w>+
nnoremap <C-9> <C-w>-
"nnoremap <C-H> <C-w>H
"nnoremap <C-J> <C-w>J
"nnoremap <C-K> <C-w>K
"nnoremap <C-L> <C-w>L

"rotate window
nnoremap <A-r> <C-w>r

"copy rest text of a current line
nnoremap <S-y> y$

"jump to first and last character on the current line
nnoremap <A-h> ^
nnoremap <A-l> $
vnoremap <A-h> ^
vnoremap <A-l> $


"modify the status line
set statusline=%t\ %{FugitiveStatusline()}\ FileType:\ %y\ FileEncoding:\ %{&fenc}%=%P\ 0x%02B\ %3c
"set statusline=%F%m%r%<\ %=%l,%v\ [%L]\ %p%%
"hi statusline ctermbg=white ctermfg=black
set laststatus=2

"set terminal encoding to latin1 to support ALT key and macros, but it means
"that mouse doesn't work
"TODO//set termencoding=latin1

"}}}

