if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-vinegar'
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-commentary'
Plug 'robertmeta/nofrils'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()


syntax on
colorscheme nofrils-dark
filetype plugin indent on
set exrc
set secure
set autoindent
set copyindent

" set completions to only use menu, and not preview
" set completeopt=

"  timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays.
set timeoutlen=1000
set ttimeoutlen=0

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
set path +=/usr/local/include/c++/**
set path +=/usr/local/Cellar/boost/1.64.0_1/include/

" dictionary settings
" set spell spelllang=en_us
" hi clear SpellBa
" hi SpellBad cterm=undercurl
" hi clear SpellCap
" hi SpellCap cterm=underline

" display everything that matches when we hit tab on a command
set wildmenu
set wildmode=list:longest

" set visualbell
set ttyfast
set backspace=indent,eol,start
set encoding=utf-8
" set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" set the number of lines when scrolling above displayed page
set scrolloff=15

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

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

" allow transparency
highlight Normal ctermbg=none

" keymaps

inoremap kj <Esc>
vnoremap kj <Esc>

" Search mappings: These will make it so that going to the next item in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" switch in and out of terminal mode in nvim
nnoremap <C-h> <c-\><c-n><c-w>h
nnoremap <C-j> <c-\><c-n><c-w>j
nnoremap <C-k> <c-\><c-n><c-w>k
nnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <Esc> <C-\><C-n>

" retain highlighted section after indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" remap left/right
noremap h b
noremap b h
noremap f w
noremap w f

" remap l to select current line
nnoremap l <S-v>
vnoremap l <S-v>

" set leader,
let mapleader=" "

nnoremap <leader>r :Rg<space>
nnoremap <leader>f :Files<cr>
nnoremap <leader>t :terminal<cr>
nnoremap <leader>c :Commands<cr>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :BCommits<CR>
nnoremap <leader>h :Lines<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>x :q<cr>
nnoremap <leader><leader> :
vnoremap <leader><leader> :
tnoremap <leader><leader> :
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Command to toggle paste mode on and off
set pastetoggle=<leader>v

" set vim to ignore these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*
