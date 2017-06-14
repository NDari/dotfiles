call plug#begin('~/.vim/plugged')

"Add the needed bundles. Note that the first one must be vundle itself.
" General
Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'w0rp/ale'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-powerline'
Plug 'mileszs/ack.vim'

Plug 'altercation/vim-colors-solarized'

" ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" nofrills
Plug 'robertmeta/nofrils'

" Go
Plug 'fatih/vim-go'
" Plug 'jodosha/vim-godebug'

" HTML/Handlebars
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'

" end plugin definitions
call plug#end()

" put filetype back on after all vundle stuff
filetype plugin indent on
set exrc
set secure
set autoindent
set copyindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"  timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays.
set timeoutlen=1000
set ttimeoutlen=0

" set font and size for macvim
set guifont=Consolas:h14
set guioptions=

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

" when opening a file, to the line from last session
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" use tags files
set tags=./.tags;/

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
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" enable persistent undo
set undofile
set undodir=~/.vim/undodir//

" add c++ includes to the path for automatic definition jumps
set path +=/usr/include/c++/**

" dictionary settings
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=undercurl
hi clear SpellCap
hi SpellCap cterm=underline

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

" Set tabwidth to 2 for HTML and Ruby, ECMAScript, and handlebars
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 softtabstop=2

" and 4 for Go and Cpp
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Move around in splits natuarally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make splits open naturally
set splitbelow
set splitright

" Ale settings
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'go': ['goimports', 'go vet', 'golint', 'go build'],
\   'ruby': ['rubocop'],
\   'cpp': ['clang++'],
\}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" better highlighting for c++ classes
let g:cpp_class_scope_highlight = 1

" allow transparency
highlight Normal ctermbg=none

" retain highlighted section after indentation
vnoremap > >gv
vnoremap < <gv

" make vim-sneak repeat with s
let g:sneak#s_next = 1

" neoComplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
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
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" neoSnippets
" expand snippet with control k, jump to next point with tab
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

" set leader,
let mapleader=","

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
