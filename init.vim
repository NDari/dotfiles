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

" auto-add closing braces of all kinds, and matching qoutes.
Plug 'jiangmiao/auto-pairs'

" open locationlist and quickfix with leader l and q
Plug 'Valloric/ListToggle'

" commenting lines. gcc for current line, gc10j to comment 10 lines down
Plug 'tpope/vim-commentary'

" Dash integration (Mac only)
Plug 'rizzatti/dash.vim'

" navigate between vim splits and tmux splits using ctrl-direction
Plug 'christoomey/vim-tmux-navigator'

" align things. Visual selection -> :Tabularize /{pattern}
Plug 'godlygeek/tabular'

" Go plugin. Do :GoInstallBinaries after this to install everything it needs.
Plug 'fatih/vim-go'

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
Plug 'vim-syntastic/syntastic'

" looks
Plug 'flazz/vim-colorschemes'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
" tags command
let g:fzf_tags_command = 'ctags -R -f .tags'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': 'enew' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

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

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" checkers
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_go_checkers = ['go', 'govet', 'golint', 'errcheck']

" configure loclist and quickfix list
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 10

" vim-racer configs
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" Vim configs

" rust specific key commands
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

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
set encoding=utf-8
set laststatus=2 " Always display the statusline in all windows
" set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

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

" Search mappings: These will make it so that going to the next item in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" Delete trailing whitespace on save
au BufWritePre *.* :%s/\s\+$//e

"Set color scheme
" set t_Co=256
set termguicolors
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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --no-heading '.shellescape(<q-args>), 1)
noremap <leader>g :Rg<space>

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

" search the thing under cursor with dash
nnoremap <leader>d :Dash<cr>

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
