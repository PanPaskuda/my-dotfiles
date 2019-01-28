
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"=========================================================
"    TODO
"=========================================================
"  +  terminal view
"  +  preproc view

"=========================================================
"=                        VUNDLE                         =
"=========================================================
"HELP: How to install vudle:
"   set up Vundle:
"       git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"HELP: to install all plugins run:
"   :BundleUpdate
"because of Vundle
set nocompatible
filetype off " required

set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

"call vundle#rc()

" Let Vundle manage Vundle
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'
"My Bundles
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
"TODO needed? Plugin 'vim-airline/vim-airline-themes'
Plugin 'mbbill/undotree'
Plugin 'altercation/vim-colors-solarized'
"ADD: Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
"TODO old ctrlP Plugin 'vim-scripts/Command-T'
"TODO new ctrlP to check Plugin 'vim-ctrlspace/vim-ctrlspace'
"TODO to check: Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/The-NERD-tree'
"Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/snipMate'
Plugin 'vim-scripts/Mark--Karkat'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
"to check:
"Plugin 'Raimondi/delimitMate' provides automatic closing of quotes, parenthesis, brackets, etc.

call vundle#end()


syntax on "syntax highlighting
set background=dark

if has("autocmd") "to jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

filetype plugin indent on
filetype plugin on


"===========================================================
"=                         GENERAL                         =
"===========================================================
set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set autowrite   " Automatically save before commands like :next and :make
set hidden     " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)
set hlsearch    "highlight all search results
set list listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:o,space:·
set list
set incsearch   " highlight find results during writing /fin...
set textwidth=100
set colorcolumn=+1
set wildmenu "pres 'wildchar' (usually <Tab>) to invoke completion,
set autoread "automatically read changed file again.
"set ruler TODO to delete
set cmdheight=2 " Height of the command bar
set updatetime=100 "100ms time of upadating i.e. gitgutter signs
set nrformats-=octal
" set path+=** TODO check how it works

let mapleader=","

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
    set backupdir=$VIM\backup
    set directory=$VIM\tmp
else
    set backupdir=~/.vim/backup
"TODO how to swoitch off swap files    set directory=~/.vim/swap
endif


"===========================================================
"=                         CSCOPE                          =
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
        echo "Adding user cscope db"
        cscope add cscope.out
    "else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        echo "Adding default cscope db"
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
        :cscope kill 0
        :!cscope -b -i cscope.files -f cscope.out
        :!del /Q cscope.files
        :cscope add cscope.out
        :CCTreeCscopeDb cscope.out
    else
        :!find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > cscope.files
        :!cscope -b -i cscope.files -f cscope.out
        :!rm cscope.files
        :cscope kill 0
        :cscope add cscope.out
        :CCTreeCscopeDb cscope.out
    endif
endfunction


"===========================================================
"=                         CCTREE                          =
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


"=========================================================
"=                      YouCompleteMe                    =
"=========================================================
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


"=========================================================
"=                    MULTIPLE_CURSORS                   =
"=========================================================
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1


"=========================================================
"=                      GIT_GUTTER                       =
"=========================================================
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


"=========================================================
"=                         GREP                          =
"=========================================================
    if has("win32")
        set rtp +=c:\tools\grep\
    else
        "TODO linux
    endif


"=========================================================
"=                      SURROUND                         =
"=========================================================
"options: ds, cs, cS, ys, yS, yss, ySs, ySS
" cs"'    to change surrounding " to '
" ds" To remove the delimiters entirely
" cst" To go full circle
"ysiw] to surround inner word
" cs]{ to change braces to square braces and add some space (use } instead of { for no space): cs]{
" yssb or yss) to wrap the entire line in parentheses


"=========================================================
"=                    INDENT_GUIDES                      =
"=========================================================
let g:indent_guides_enable_on_vim_startup = 1
"nmap <silent><unique> <Leader>ig <Plug>IndentGuidesToggle


"=========================================================
"=                       UNDO_TREE                       =
"=========================================================
let g:loaded_undotree = 1 "widow style
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif


"=========================================================
"=                         SPELL                         =
"=========================================================
set spl=en spell "set spell checking to English
set spell


"=========================================================
"=                   VIM DIFF TOGGLE                     =
"=========================================================
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


"=========================================================
"=                     SPLIT TOGGLE                      =
"=========================================================
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


" call SplitToggle() to save settings
"=========================================================
"=                  TAB/SPACES TOGGLE                    =
"=========================================================
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


"=========================================================
"=                     DRAG VISUALS                      =
"=========================================================
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


"=========================================================
"=                      COLOR SCHEME                     =
"=========================================================
set background=dark
colorscheme solarized
highlight ExtraWhitespace ctermfg=white ctermbg=red guifg=white guibg=red

highlight NERDTreeDir guibg=#002b36 guifg=#268bd2

"tabs and trailing spaces (ignore ^\t ):
"match ExtraWhitespace /[^\t^][\t]\|\s\+$\| \+\ze\t/
"tabs and trailing spaces:
match ExtraWhitespace /[\t]\|\s\+$\| \+\ze\t/

"NOTE: weird bahaviour after settings a guifont: resize of the gvim window
"set guifont=Consolas "set fonts for gVim: 0Oo, |1lIiL





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



"=========================================================
"=                        CTRL-P                         =
"=========================================================
"NOTE: <C-UP> / <C-DOWN> to switch buff / MRU / files
"NOTE press <F5> inside CtrlP to refresh cache

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'rw' "begin finding a root from the current working directory
let g:ctrlp_max_height = 20 " Set the maximum height of the match window:
let g:ctrlp_regexp = 0 "Set this to 1 to set regexp search as the default: toggle: <c-d>
let g:ctrlp_by_filename = 0 "set searching by filename (as opposed to full path) toggle <c-r>
let g:ctrlp_mruf_relative = 1 "show only MRU files in the current working directory
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\..*$',
    \ 'file': '\v\.(exe|so|dll|html|out|log|tmp)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
    "\ 'dir':  '\v[\/]\.(git|hg|svn)$',

"TODO auto set:
"* A standalone function to set the working directory to the project's root, or
"  to the parent directory of the current file if a root can't be found:
"  function! s:setcwd()
"    let cph = expand('%:p:h', 1)
"    if cph =~ '^.\+://' | retu | en
"    for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
"      let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
"      if wd != '' | let &acd = 0 | brea | en
"    endfo
"    exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
"  endfunction
"
"  autocmd BufEnter * call s:setcwd()

"=========================================================
"=                    SILVER SERCHER                     =
"=========================================================
"let g:ackprg = 'ag --nogroup --nocolor --column'


"=========================================================
"=                     EASY MOTION                       =
"=========================================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case insensitive feature


"=========================================================
"=                  SHORT KEYS MAPPING                   =
"=========================================================
"=                    ARROW KEYS                         =
"NOTE: can by added by plugin: wikitopian/hardmode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"=                      F1 - F12                         =
"nmap <F1> :set rnu<CR> "set relative number
"nmap <S-F1> :set nu<CR> "set number
"nmap <F1> :%bd|e#<CR><CR>
nmap <F1> :%bd<CR><CR>
nnoremap <F2> :UndotreeToggle<CR>
map <F3> :TlistToggle<CR>
map <F4> :NERDTreeToggle<CR>
nmap <F5> :set spell!<CR>
map <F6> :set cursorline!<CR>
noremap <silent> <F8> :<C-U>call TabsSpacesToggle()<CR>
noremap <silent> <F8> :<C-U>call TabsSpacesToggle()<CR>
nnoremap <silent> <F9> :<C-U>call VimDiffToggle()<CR>
nnoremap <silent> <F10> :<C-U>call SplitToggle()<CR>
nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>:YcmDiag<CR>
"map <F12> :call CreateTags()<CR>
map <silent><F12> :call CreateCscopeDatabase()<CR>


"=                      GENERAL                         =
"put enter and strip in previous line all spaces till the nearest non space
nmap K :call StringTrailingWhiteSpace()<CR>i<CR><ESC>
nmap <CR> A<CR><ESC>
"strip all spaces till the nearest non space sign
"enable/disable spell checking
nmap <leader>s z=
"TODO: how to fix it nmap <Leader>gh :h <cword><CR>



"=                     EASY MOTION                       =
" Jump to anywhere you want with minimal keystrokes, with just one key binding:   `s{char}{label}`
nmap <space> <Plug>(easymotion-overwin-f)
" or  `s{char}{char}{label}`   Need one more keystroke, but on average, it may be more comfortable.
nmap <leader><space> <Plug>(easymotion-overwin-f2)

nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>W <Plug>(easymotion-W)
nmap <Leader>b <Plug>(easymotion-b)
nmap <Leader>B <Plug>(easymotion-B)
nmap <Leader>e <Plug>(easymotion-e)
nmap <Leader>E <Plug>(easymotion-E)
nmap <Leader>ge <Plug>(easymotion-ge)
nmap <Leader>gE <Plug>(easymotion-gE)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
"nmap <Leader>n <Plug>(easymotion-bd-n)
"nmap <Leader>N <Plug>(easymotion-N)
"nmap <Leader>s <Plug>(easymotion-s)


"=                         CSCOPE                          =
"create database for C
map <leader>csa :call CreateCscopeDatabase()<CR>

" find callers:
map <Leader>fc :cscope f c <cword><CR>
" find callees:
map <Leader>fd :cscope f d <cword><CR>
" find definition:
map <Leader>fg :cscope f g <cword><CR>
" find file:
map <Leader>ff :cscope f f <cword><CR>
" find files including this:
map <Leader>fi :cscope f i %:t<CR>
" find symbol:
map <Leader>fs :cscope f s <cword><CR>
" find text:
map <Leader>ft :cscope f t <cword><CR>
" grep this:
map <Leader>fe :cscope f e <cword><CR>

map <Leader>fa :!grep -rn --include="*.[ch]" <cword> .<CR>

"use 'v' or 's' to open in new split or vertical window
nmap <Leader>fvs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fvg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fvc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fvt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fvf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader>fvi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader>fvd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fva :vert scs find a <C-R>=expand("<cword>")<CR><CR>

nmap <Leader>fss :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fsg :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fsc :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fst :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fse :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fsf :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader>fsi :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader>fsd :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>fsa :scs find a <C-R>=expand("<cword>")<CR><CR>

"=                      YouCompleteMe                    =
nnoremap <Leader>yy :YcmCompleter<CR>
"jump back
nmap <leader>jb <C-O>
"jump forward
nmap <leader>jf <C-I>

"DefinitionElseDeclaration<CR>
nnoremap <silent> <leader> yg :YcmCompleter GoTo <CR>
nnoremap <silent> <Leader>i :TlistToggle<CR>
nnoremap <silent> <Leader>j :NextError<CR>
nnoremap <silent> <Leader>k :PrevError<CR>
nnoremap <silent> <Leader>h :OlderError<CR>
nnoremap <silent> <Leader>l :NewerError<CR>
nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>yr :YcmRestartServer<CR>
nnoremap <silent> <Leader>yc :YcmForceCompileAndDiagnostics<CR>
nnoremap <silent> <Leader>yd :YcmDiag<CR>
nnoremap <silent> <Leader>ys :YcmShowDetailedDiagnostic<CR>
nnoremap <silent> <Leader>yn :YcmCompleter<CR>
nnoremap <silent> <Leader>yi :YcmDebugInfo<CR>
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

"=                     CCTREE                      =
"TODO cctree not works and set custom shortcuts
let g:CCTreeKeyTraceForwardTree = '<C-\>>'
let g:CCTreeKeyTraceReverseTree = '<C-\><'
let g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting
let g:CCTreeKeySaveWindow = '<C-\>y'
let g:CCTreeKeyToggleWindow = '<C-\>w'
let g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree
let g:CCTreeKeyDepthPlus = '<C-\>='
let g:CCTreeKeyDepthMinus = '<C-\>-'


"=                    MULTIPLE_CURSORS                   =
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"=                     DRAG VISUALS                      =
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')


"=                         TABS                          =
"create tab
nmap <leader>tcr :tabnew<CR>
"close tab
nmap <leader>tcl :tabclose<CR>
"move tab
nmap <leader>tm :tabmove<CR>
"next tab
nmap <leader>tn :tabnext<CR>
"previous tab
nmap <leader>tp :tabprevious<CR>
"first tab
nmap <leader>tf :tabfirst<CR>


"shift lines using alt+jk (in all modes)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"sugestion for autocompletion C/C++ word
imap <leader>c <C-x><C-o>

"coment-out
nmap <leader>o 'aO#if 0<ESC>'zo#endif<ESC>0

"delete sign - like 'x' in normal mode
imap <A-x> <del>
cmap <A-x> <del>

"close all
map <C-q> :qall<CR>

"actions for window: resize, equal, navigate
nmap <C-=> <C-w>=
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-0> <C-w>+
nmap <C-9> <C-w>-
"nmap <C-H> <C-w>H
"nmap <C-J> <C-w>J
"nmap <C-K> <C-w>K
"nmap <C-L> <C-w>L

"rotate window
nmap <A-r> <C-w>r

"copy rest text of a current line
nmap <S-y> y$

"jump to first and last character on the current line
nmap <A-h> ^
nmap <A-l> $
vmap <A-h> ^
vmap <A-l> $

"set buffer for copy/paste
map <A-a> "a
map <A-b> "b
map <A-c> "c





"tab set to 4 spaces
set tabstop=4
set backspace=indent,eol,start "make backspace work like most other programs

"remove tab to spaces
set expandtab

set sw=4

"set relative number
set rnu

"set current line number
set number

"disable creation backup files
set nobackup
set noswapfile

"treat *.cog files as "c" files
au BufRead,BufNewFile *.cog        setfiletype c

"if cursor doesn't move, check whether the current file is up to date
au CursorHold * checktime

"modify the status line
set statusline=%t\ %{FugitiveStatusline()}\ FileType:\ %y\ FileEncoding:\ %{&fenc}%=%P\ 0x%02B\ %3c
"set statusline=%F%m%r%<\ %=%l,%v\ [%L]\ %p%%
"hi statusline ctermbg=white ctermfg=black
set laststatus=2

"set terminal encoding to latin1 to support ALT key and macros, but it means
"that mouse doesn't work
"TODO//set termencoding=latin1


