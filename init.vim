call plug#begin('~/.local/share/nvim/plugged')

"Add the needed bundles. Note that the first one must be vundle itself.
" General
Plug 'gmarik/vundle'
Plug 'posva/vim-vue'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'Lokaltog/vim-powerline'
Plug 'tpope/vim-commentary'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" Dart
Plug 'dart-lang/dart-vim-plugin'

" Go
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

" HTML/Handlebars
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'

" Initialize plugin system
call plug#end()

filetype plugin indent on
set exrc
set secure
set autoindent
set copyindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

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
set background=light
syntax on
colorscheme solarized

" Set mouse behavior to be more normal
set mouse=a

" Terminal navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor

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
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 softtabstop=2

" and 4 for Go and Cpp
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

" source the file on init
autocmd VimEnter * source $MYVIMRC

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
\   'dart': ['dartanalyzer'],
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

" ctrlP
" ignore files in the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
if executable("ack")
  set grepprg=ack\ --nogroup\ --nocolor
endif
let g:ctrlp_show_hidden = 1

" set leader,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" quick buffer switching
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>d :bd<cr>

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
