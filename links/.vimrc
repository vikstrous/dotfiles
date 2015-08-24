set nocompatible
syntax on
colorscheme molokai
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
setlocal spell spelllang=en_us
set mouse=a
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
let c_space_errors=1
set incsearch
set smartcase
set ignorecase
"set cursorline
"set cursorcolumn
set formatoptions=l
set backspace=indent,eol,start
set lbr
set clipboard=unnamedplus
set number

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" move by screen lines, not by real lines - great for creative writing
nnoremap j gj
nnoremap k gk
" also in visual mode
vnoremap j gj
vnoremap k gk

" Use ctrl-[hjkl] to select the active split!
map Od <C-left>
map Oc <C-right>
map Oa <C-up>
map Ob <C-down>
map! Od <C-left>
map! Oc <C-right>
map! Oa <C-up>
map! Ob <C-down>
map <C-up> <C-w><up>
map <C-down> <C-w><down>
map <C-left> <C-w><left>
map <C-right> <C-w><right>

execute pathogen#infect()
