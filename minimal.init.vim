filetype plugin indent on
set exrc
set secure
set copyindent

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

" use tags files. search "tags" file in the current directory where vim was
" opened, and if not found, keep going up until $HOME.
set tags+=./.tags,.tags;$HOME

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

" show me the command i am typing
set showcmd

" set one location for all the swap and backup files
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swp//

" enable persistent undo
set undofile
set undodir=~/.config/nvim/undodir//

set wildmenu
set visualbell
set ttyfast
set backspace=indent,eol,start
set encoding=utf-8
set laststatus=2 " Always display the statusline in all windows
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" set the number of lines when scrolling above displayed page
set scrolloff=15

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

"Set color scheme
" set t_Co=256
set termguicolors
set background=dark
syntax on

" Set mouse behavior to be more normal
set mouse=a

" set tabs to 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Make splits open naturally
set splitbelow
set splitright

" set path to include current dir and all sub dirs recur
set path+=**


" netrw settings
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3

" mapping
"vnoremap : ;
"vnoremap ; :
"nnoremap : ;
"nnoremap ; :

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" terminal mode escaping and window changing
tnoremap <c-w><c-w> <c-\><c-n><c-w><c-w>
tnoremap <esc> <c-\><c-n>
