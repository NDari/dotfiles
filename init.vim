call plug#begin('~/.local/share/nvim/plugged')

" General

" s + 2 characters to jump to anything with those two characters.
" press s repeatedly to jump to next.
Plug 'justinmk/vim-sneak'

" replace normal f. now, pressing f repeatedly after a match will
" take you to the next match in the line. matches are highlighted.
Plug 'rhysd/clever-f.vim'

" autocompletion. Requires python 3 and pip3 install neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" ysiw' -> surround word with '. cs"' -> cs " to '. ds" -> delete surrounding ".
Plug 'tpope/vim-surround'

" get ability to repear more complex tasks with .
Plug 'tpope/vim-repeat'

" add "end" to things like ruby and fortran after a do and if.
Plug 'tpope/vim-endwise'

" navigate errors with ]q and [q, buffers with ]b and [b and much more.
Plug 'tpope/vim-unimpaired'

" auto-add closing braces of all kinds, and matching qoutes.
Plug 'jiangmiao/auto-pairs'

" commenting lines. gcc for current line, gc10j to comment 10 lines down
Plug 'tpope/vim-commentary'

" navigate between vim splits and tmux splits using ctrl-direction
Plug 'christoomey/vim-tmux-navigator'

" align things. Visual selection -> :Tabularize /{pattern}
Plug 'godlygeek/tabular'

" Go plugin. Do :GoInstallBinaries after this to install everything it needs.
Plug 'fatih/vim-go'

" Rust plugin. Use rustup. then
" `rustup update` to get the latest.
" `rustup toolchain install nightly` to install nightly
" `rustup run nightly cargo install clippy` our linter
" `cargo install rustfmt` for formatting
" `cargo install racer` to get the docs
Plug 'rust-lang/rust.vim'

" enable web apis. Currently needed for rust's playpen
Plug 'mattn/webapi-vim'

" enable using fzf for most things. Probably install first.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"
" linting
Plug 'w0rp/ale'

" looks
Plug 'flazz/vim-colorschemes'
Plug 'Lokaltog/vim-powerline'
Plug 'robertmeta/nofrils'
Plug 'liuchengxu/space-vim-dark'

" nerdtree
Plug 'scrooloose/nerdtree'

" show the changed files in git in the nerdtree panel
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'  }

" See git changes on the gutter
Plug 'airblade/vim-gitgutter'

" awesome git management with :G*
Plug 'tpope/vim-fugitive'

" Debug go. Only works in neovim. Set breakpoints with :GoToggleBreakpoint and
" debug with :GoDebug. Needs dlv installed.
Plug 'jodosha/vim-godebug'

" HTML/Handlebars. Generate things with writing the commands, then c-y , to
" generate. For example li*5<c-y> , will generate 5 li for you with closing
" tags.
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()

" Plugin configs

" deoplete settings
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

" fzf.vim settings
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" make vim-sneak repeat with s
let g:sneak#s_next = 1

" make clever f only search across one line
let g:clever_f_across_no_line = 1
" use smart case
let g:clever_f_ignore_case = 1
" let ; be {, ( " % etc
let g:clever_f_chars_match_any_signs = ";"

" Vim configs

" source the file on init
autocmd VimEnter * source $MYVIMRC

filetype plugin indent on
set exrc
set secure
set autoindent
set copyindent
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

" settings for speed improvements
set nocursorcolumn       " do not highlight column
syntax sync minlines=100 " start highlighting from this many lines backwards
set synmaxcol=120        " do not highlight very long lines
set re=1                 " use explicit old regexpengine, seems to be more "

" use tags files. search "tags" file in the current directory where vim was
" opened, and if not found, keep going up until $HOME.
set tags+=./tags,tags;$HOME

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

" nofrils settings
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1
let g:nofrils_heavycomments=0

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" vim-rust settings
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'

" Search mappings: These will make it so that going to the next item in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

"Set color scheme
set t_Co=256
set background=dark
syntax on
colorscheme gruvbox
hi Comment cterm=italic

" Set mouse behavior to be more normal
set mouse=a

" Set tabwidth to 2 for HTML and Ruby, ECMAScript, and handlebars
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType erb setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Make splits open naturally
set splitbelow
set splitright

" allow transparency
highlight Normal ctermbg=none

" retain highlighted section after indentation
vnoremap > >gv
vnoremap < <gv

" set leader,
let mapleader=","

" grep things
noremap <leader>g :Find<Space>

" show my my buffers with fzf
noremap <leader>b :Buffers<CR>

" show commits with fxf
noremap <leader>c :BCommits<CR>

" search files with fuzzy finder
nnoremap <leader>e :Files<cr>

" search files with fuzzy finder
nnoremap <leader>t :Tags<cr>

" search vim's file history with fuzzy finder
nnoremap <leader>h :History<cr>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Toggle nerdtree on and off
map <leader>f :NERDTreeToggle<CR>

" Command to toggle paste mode on and off
set pastetoggle=<leader>v

" set vim to ignore these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" dont use escape key
imap kj <Esc>

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
