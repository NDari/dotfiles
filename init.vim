if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !mkdir -p ~/.config/nvim/{backup,swp,undodir}
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" General
" s + 2 characters to jump to anything with those two characters.
" press s repeatedly to jump to next.
Plug 'justinmk/vim-sneak'

" vim completion with ease of using tabs
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" ysiw' -> surround word with '. cs"' -> cs " to '. ds" -> delete surrounding ".
Plug 'tpope/vim-surround'

" []q quickfix, []b buffer, []a file,
Plug 'tpope/vim-unimpaired'

" get ability to repear more complex tasks with .
Plug 'tpope/vim-repeat'

" auto-add closing braces of all kinds, and matching qoutes.
Plug 'jiangmiao/auto-pairs'

" open locationlist and quickfix with leader l and q
Plug 'Valloric/ListToggle'

" commenting lines. gcc for current line, gc10j to comment 10 lines down
Plug 'tpope/vim-commentary'

" navigate between vim splits and tmux splits using ctrl-direction
Plug 'christoomey/vim-tmux-navigator'

" align things. Visual selection -> :Tabularize /{pattern}
Plug 'godlygeek/tabular'

" Go plugin. Do :GoInstallBinaries after this to install everything it needs.
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Debug go. Only works in neovim. Set breakpoints with :GoToggleBreakpoint and
" debug with :GoDebug. Needs dlv installed.
Plug 'jodosha/vim-godebug'

" Rust plugin. Use rustup. then
" `rustup update` to get the latest.
" `cargo install rustfmt` for formatting
" `cargo install racer` to get the docs
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'timonv/vim-cargo'

" enable using fzf for most things. Probably install first.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"
" linting
Plug 'w0rp/ale'

" looks
Plug 'NLKNguyen/papercolor-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'robertmeta/nofrils'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'

" nerdtree
Plug 'tpope/vim-vinegar'

" awesome git management with :G*
Plug 'tpope/vim-fugitive'

" python
" Jedi for static analysis and completion
Plug 'davidhalter/jedi-vim'
" make deoplete use jedi
Plug 'zchee/deoplete-jedi'
" better syntax
Plug 'vim-python/python-syntax'

" terminal
Plug 'mklabs/split-term.vim'

" repl
Plug 'https://gitlab.com/HiPhish/repl.nvim'


" writing
Plug 'junegunn/goyo.vim'

" Initialize plugin system
call plug#end()

" Plugin configs

"deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" airline
let g:airline_theme='papercolor'

" enable all python syntax
let g:python_highlight_all = 1

" vim-jedi settings
let g:jedi#force_py_version = 3
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#rename_command = ""

" fzf.vim settings
" tags command
let g:fzf_tags_command = 'ctags -R -f .tags'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': 'enew' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" vim-go settings
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_doc_keywordprg_enabled = 1 "run godoc for word under cursor with K
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" make vim-sneak repeat with s
let g:sneak#s_next = 1

" configure loclist and quickfix list
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 10

" vim-racer configs
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" nofrils settings
let g:nofrils_heavylinenumbers=0
let g:nofrils_strbackgrounds=0
let g:nofrils_heavycomments=0

" vim-rust settings
let g:rustfmt_autosave = 1

" disable tmux-navigator when zoomed
let g:tmux_navigator_disable_when_zoomed = 1

" Vim configs

" rust specific key commands
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
" autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

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

" highlight current line
set cursorline

" Set both relative AND absolute numbers on. (requires vim 7.4)
" set relativenumber
" set number

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

" dictionary settings
" set spell spelllang=en_us
" hi clear SpellBa
" hi SpellBad cterm=undercurl
" hi clear SpellCap
" hi SpellCap cterm=underline

" display everything that matches when we hit tab on a command
set wildmenu
set wildmode=list:longest

set visualbell
set ttyfast
set backspace=indent,eol,start
set encoding=utf-8
" set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" set the number of lines when scrolling above displayed page
set scrolloff=15

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

"Set color scheme
" set t_Co=256
set termguicolors
set background=dark
syntax on
colorscheme PaperColor

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

" keymaps
" Search mappings: These will make it so that going to the next item in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" switch in and out of terminal mode in nvim
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <Esc> <C-\><C-n>

" retain highlighted section after indentation
vnoremap > >gv
vnoremap < <gv

" remap l to select current line
nnoremap l <S-v>
vnoremap l <S-v>

" set leader,
let mapleader=" "

nnoremap <leader>g :Rg<space>
nnoremap <leader>f :Files<cr>
nnoremap <leader>t :VTerm<cr>
nnoremap <leader>c :Commands<cr>
nnoremap <leader>b :Buffers<CR>
" nnoremap <leader> :BCommits<CR>
nnoremap <leader>h :Lines<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>x :q<cr>
nnoremap <leader><leader> :
vnoremap <leader><leader> :
tnoremap <leader><leader> :

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Command to toggle paste mode on and off
set pastetoggle=<leader>v

" set vim to ignore these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" replace silver searcher (AG) with ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
