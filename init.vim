call plug#begin('~/.local/share/nvim/plugged')

" General
Plug 'justinmk/vim-sneak'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'
Plug 'mhinz/vim-grepper'
Plug 'sheerun/vim-polyglot'
Plug 'Valloric/ListToggle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" linting
Plug 'w0rp/ale'

" looks
Plug 'flazz/vim-colorschemes'
Plug 'Lokaltog/vim-powerline'
Plug 'robertmeta/nofrils'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'  }

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" searching
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'

" ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" Dart
Plug 'dart-lang/dart-vim-plugin'

" Kotlin
Plug 'udalov/kotlin-vim'

" Go
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

" HTML/Handlebars
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'

" C/C++
Plug 'osyo-manga/vim-snowdrop'
Plug 'osyo-manga/vim-marching'
Plug 'octol/vim-cpp-enhanced-highlight'

" lisp
Plug 'vim-scripts/Limp'

" Initialize plugin system
call plug#end()

" source the file on init
autocmd VimEnter * source $MYVIMRC

filetype plugin indent on
set exrc
set secure
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"  timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays.
set timeoutlen=1000
set ttimeoutlen=0

" highlight current line
set cursorline

" Set both relative AND absolute numbers on. (requires vim 7.4)
set relativenumber
set number

" highlight searches
set hlsearch

" ignore case for searches, unless it starts with upper case
set ignorecase
set smartcase

" when opening a file, to the the line from last session
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" use tags files
set tags=./tags;/

" make vim's clipboard to be the same as the system's clipboard
set clipboard=unnamed

" show match while typing
set incsearch

" set a huge history and a huge undo
set history=10000
set undolevels=10000

set title

" Do not close modified buffers, but hide them
set hidden

" automatically write before things like :next
set autowrite

" show the current mode
set showmode

" show me the command i am typing
set showcmd

" set one location for all the swap and backup files
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swp//

" enable persistent undo
set undofile
set undodir=~/.config/nvim/undodir//

" add c++ includes to the path for automatic definition jumps
set path +=/usr/include/c++/**
set path +=/usr/local/include/c++/**
set path +=/usr/local/Cellar/boost/1.64.0_1/include/


" dictionary settings
" set spell spelllang=en_us
" hi clear SpellBad
" hi SpellBad cterm=undercurl
" hi clear SpellCap
" hi SpellCap cterm=underline

" display everything that matches when we hit tab on a command
set wildmenu
set wildmode=list:longest

set visualbell
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set encoding=utf-8

" set the number of lines when scrolling above displayed page
set scrolloff=10

" go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" vimgrepper
let g:grepper = {}
runtime autoload/grepper.vim
let g:grepper.jump = 1
let g:grepper.stop = 500

" nofrils settings
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1
let g:nofrils_heavycomments=0

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

"Set color scheme
set t_Co=256
set background=dark
syntax on
colorscheme solarized

" Set mouse behavior to be more normal
set mouse=a

" ack.vim
" Use ripgrep for ack.vim if exists
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

" deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" remove the scractch window automaticallly
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Set tabwidth to 2 for HTML and Ruby, ECMAScript, and handlebars
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType erb setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Make splits open naturally
set splitbelow
set splitright

" better highlighting for c++ classes
let g:cpp_class_scope_highlight = 1

" allow transparency
highlight Normal ctermbg=none

" retain highlighted section after indentation
vnoremap > >gv
vnoremap < <gv

" make vim-sneak repeat with s
let g:sneak#s_next = 1

" ctrlP
" ignore files in the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" use ripgrep for grepping (brew install ripgrep)
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif
let g:ctrlp_show_hidden = 1

" split term settings
let g:split_term_vertical = 1
let g:disable_key_mappings = 1

" set leader,
let mapleader=","

" map the ripgrep grepper
noremap <leader>gr :GrepperRg<Space>

" toggle quick and location lists
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
" and set their height to 10
let g:lt_height = 15

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" quick buffer switching with buffergator
map <leader>n gb
map <leader>p gB

" Toggle nerdtree on and off
map <leader>f :NERDTreeToggle<CR>

" Command to toggle paste mode on and off
set pastetoggle=<leader>v

" set vim to ignore these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" dont use escape key
imap kj <Esc>

nmap ; :

" space for scolling down
nn <space>  <c-d>

" OSX/Linux specific stuff
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    " Do Mac stuff here
  endif
  if s:uname == "Linux"
    " Do Linux stuff here
  endif
endif
