" Plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'chriskempson/base16-vim'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline-themes'
Plug 'derekwyatt/vim-scala'
Plug 'vivien/vim-linux-coding-style'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'dag/vim-fish'
Plug 'hashivim/vim-terraform'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

" basics ----------------------------------------------

" make the leader key easy to access
let mapleader = " "

" essential for pretty much everything - don't do any vi crap
set nocompatible

" always use syntax highlighting
syntax on

" hack with style
set background=dark
let base16colorspace=256
colorscheme base16-default-dark

" spell check always on
set spell

" make indentation reasonable most of the time
set tabstop=4
set shiftwidth=4
set expandtab

" show tab and eol as vertial line, trailing spaces as dots, etc.
set list
set listchars=tab:¦\ ,trail:·,extends:>,precedes:<

" 'murica spelling
setlocal spell spelllang=en_us

" enabled mouse support
set mouse=a

" always show the status bar
set laststatus=2

" show info about the current command / waiting for input at the bottom
set showcmd

" start showing search results as you type
set incsearch

" lowercase == any case
set smartcase
set ignorecase

" allow folding of code blocks optionally
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1

" wrap comments as I type them
set formatoptions+=c
" don't stay in comment mode when inserting more than one line comment
set formatoptions-=r
" don't stay in comment mode when hitting o
set formatoptions-=o
" enable gq/gw for formatting comments
set formatoptions+=q
" don't auto break regular lines in insert mode
set formatoptions+=l
" auto format paragraphs in markdown files
"au FileType markdown set formatoptions+=a

" this is pretty standard
set textwidth=80

" make backspace delete everything
set backspace=indent,eol,start
" write at reasonable characters
set linebreak
" always copy to system clipboard
set clipboard=unnamedplus
" line numbers
set number

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" unicode handling
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" NERD commenter --------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" airline -----------------------------------
let g:airline_powerline_fonts = 1
" this section is slow and not useful
let g:airline_section_x = ''

" kernel style ----------------------------------
let g:linuxsty_patterns = [ "linux" ]

" ycm ---------------------------
" don't display the silly preview window at the top when completing
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview
" recommended by syntastic I think
let g:ycm_show_diagnostics_ui = 0
" maybe speed things up?
let g:ycm_cache_omnifunc = 1

" syntastic -------------------------------------------
let g:syntastic_go_checkers = ['gofmt', 'govet']
" other useful checkrs: 'go', 'gofmt', 'gometalinter', 'golint', 'govet', 'gotype'
" configs recommended by syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_mode_map = {
        \ "mode": "active" }

" nerdtree ------------------------------------------
let NERDTreeIgnore = ['\.pyc$', '\.lo$', '\.o$', '\.la$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"au FileType go autocmd vimenter * NERDTree

" ultisnips -----------------------

let g:UltiSnipsExpandTrigger="<m-tab>"
let g:UltiSnipsJumpForwardTrigger="<down>"
let g:UltiSnipsJumpBackwardTrigger="<up>"
"let g:UltiSnipsEditSplit="vertical"

" vim-go ----------------------------------------------------

" let syntastic run gofmt too and display those errors with the other errors
let g:go_fmt_fail_silently = 1
" bug fix recommended by syntastic
let g:go_list_type = "quickfix"

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

"This is garbage. I don't know what netrw does.
:let g:netrw_dirhistmax = 0

" hotkeys -----------------------------------------

" when in wrap mode, arrow keys move through the wrapped text like in modern
" editors when when not, they move normally
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

" leader+w for toggling word wrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
" leader+q for forced syntax check
nmap <leader>q :SyntasticCheck<CR>
" leader+f for opening files
nmap <leader>f :FZF!<CR>
" leader+r for inserting a go return err block
"nmap <leader>r ierrn<m-tab><esc>
" shift tab in command mode to untab a line
"nnoremap <S-Tab> <<
" tab in command mode to tab a line
"nnoremap <Tab> >>
" shift tab in insert mode to untab a line
inoremap <S-Tab> <C-d>

" Use ctrl-[hjkl] to select the active split!
"map Od <C-left>
"map Oc <C-right>
"map Oa <C-up>
"map Ob <C-down>
"map! Od <C-left>
"map! Oc <C-right>
"map! Oa <C-up>
"map! Ob <C-down>
"map <C-up> <C-w><up>
"map <C-down> <C-w><down>
"map <C-left> <C-w><left>
"map <C-right> <C-w><right>

" leader+l to toggle showing of hidden characters
nmap <leader>l :set list!<CR>

" ???
nnoremap = za

" tagbar hotkey
nmap <F8> :TagbarToggle<CR>

" nerdtree hotkeys
map <F2> :NERDTreeToggle<CR>

" go hotkeys
"au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>e <Plug>(go-rename)


