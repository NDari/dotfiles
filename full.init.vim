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
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'Shougo/deoplete-clangx'
" Plug 'ajh17/VimCompletesMe'

" ysiw' -> surround word with '. cs"' -> cs " to '. ds" -> delete surrounding ".
Plug 'tpope/vim-surround'

" []q quickfix, []b buffer, []a file,
Plug 'tpope/vim-unimpaired'

" get ability to repear more complex tasks with .
Plug 'tpope/vim-repeat'

" auto-add closing braces of all kinds, and matching qoutes.
Plug 'jiangmiao/auto-pairs'
" and 'end'
Plug 'tpope/vim-endwise'

" sensible defaults
Plug 'tpope/vim-sensible'

" open locationlist and quickfix with leader l and q
Plug 'Valloric/ListToggle'

" commenting lines. gcc for current line, gc10j to comment 10 lines down
Plug 'tpope/vim-commentary'

" navigate between vim splits and tmux splits using ctrl-direction
Plug 'christoomey/vim-tmux-navigator'

" align things. Visual selection -> :Tabularize /{pattern}
Plug 'godlygeek/tabular'

" markdown. Note it must come after tabular
Plug 'plasticboy/vim-markdown'

" Go plugin. Do :GoInstallBinaries after this to install everything it needs.
Plug 'fatih/vim-go'
" Debug go. Only works in neovim. Set breakpoints with :GoToggleBreakpoint and
" debug with :GoDebug. Needs dlv installed.
Plug 'jodosha/vim-godebug'

" all the languages
Plug 'sheerun/vim-polyglot'

" nim
Plug 'alaviss/nim.nvim'

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
Plug 'dense-analysis/ale'

" looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'robertmeta/nofrils'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'kaicataldo/material.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/gruvbox-material'

" nerdtree
Plug 'tpope/vim-vinegar'

" save and restore sessions
Plug 'tpope/vim-obsession'

" awesome git management with :G*
Plug 'tpope/vim-fugitive'

" python
" Jedi for static analysis and completion
" Plug 'davidhalter/jedi-vim'
" better syntax
" Plug 'vim-python/python-syntax'
Plug 'psf/black'

" terminal
Plug 'mklabs/split-term.vim'

" writing
" Plug 'junegunn/goyo.vim'

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" Racket
Plug 'wlangstroth/vim-racket'
Plug 'MicahElliott/vrod'

" readline keybinding in insert and command mode
Plug 'tpope/vim-rsi'

" slime: send code to repl
Plug 'jpalardy/vim-slime'

" lsp
Plug 'neovim/nvim-lspconfig'

" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Initialize plugin system
call plug#end()

" Plugin configs

" enable ale auto completion
" let g:ale_completion_enabled = 1
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_text_changed = 'never'
" set omnifunc=ale#completion#OmniFunc " list completions with C-x C-o
" let g:ale_set_highlights = 0 " dont highlight errors inline. Margins will still work

" nvim-lsp
lua << EOF
    local lspconfig = require'lspconfig'
    lspconfig.julials.setup{
        root_dir = function(fname)
            return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir();
        end;
    }
    lspconfig.nimls.setup{}
    lspconfig.pylsp.setup{}
    lspconfig.pylsp.setup{
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              maxLineLength = 100
            }
          }
        }
      }
    }
    lspconfig.solargraph.setup{
        root_dir = function(fname)
            return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
        end;
    }
EOF
autocmd Filetype nim,ruby,julia setlocal omnifunc=v:lua.vim.lsp.omnifunc

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true              -- false will disable the whole extension
  },
}
EOF

" disable folding
set nofoldenable

" vim-markdown
let g:vim_markdown_folding_disabled = 1

"deoplete
let g:deoplete#enable_at_startup = 1

" julia
" let g:default_julia_version = '1.5'
let g:latex_to_unicode_auto = 1

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
" let g:slime_python_ipython = 1

" fzf.vim settings
" tags command
let g:fzf_tags_command = 'ctags -R -f .tags'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': 'enew' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = []

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
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1
let g:nofrils_heavycomments=1

" vim-rust settings
let g:rustfmt_autosave = 1

" disable tmux-navigator when zoomed
let g:tmux_navigator_disable_when_zoomed = 1

" set black's line length to 80
let g:black_linelength = 80

" Vim configs

" mostly for markdown
set conceallevel=2

" Julia
au FileType julia setlocal iskeyword+=@-@

" Python configs
" autocmd BufWritePost *.py silent! execute ':Black'
" autocmd BufWritePre *.py 0,$!black

" forth
autocmd FileType forth setlocal shiftwidth=8 tabstop=8 softtabstop=8

" text/markdown
autocmd FileType markdown,txt setlocal complete+=k/usr/share/dict/words

" rust specific key commands
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
" autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

filetype plugin indent on
set exrc " Add ability to have a .vimrc for each project
set secure " prevent bad .vimrc files from being bad
set autoindent
set copyindent

" set completions to only use menu, and not preview
set completeopt=menu

"  timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays.
set timeoutlen=1000
set ttimeoutlen=0

" highlight current line
set cursorline

" Set both relative AND absolute numbers on
set relativenumber
set number

" highlight searches
set hlsearch

" ignore case for searches, unless it starts with upper case
set ignorecase
set smartcase

" add typical header paths to vim
let &path.="/usr/local/include,/usr/include,~/include,"

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
set autowriteall

" show me the command i am typing
" set showcmd

" set one location for all the swap and backup files
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swp//

" enable persistent undo
set undofile
set undodir=~/.config/nvim/undodir//

" dictionary settings
" use c-x c-k for completions from dictionary
set spell spelllang=en_us
hi clear SpellBa
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
" set laststatus=2 " Always display the statusline in all windows
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" Better display for messages
set cmdheight=1

" set the number of lines when scrolling above displayed page
set scrolloff=15

" Delete trailing whitespace on save
au BufWritePre *.py :%s/\s\+$//e

"Set color scheme
" set t_Co=256
set termguicolors
set background=dark
syntax on
colorscheme base16-gruvbox-dark-medium

" Set mouse behavior to be more normal
set mouse=a

" set tabs to 2 spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Make splits open naturally
set splitbelow
set splitright

" keymaps
" Search mappings: These will make it so that going to the next item in a
" search will center on the line it's found in."
nnoremap n nzzzv
nnoremap N Nzzzv

" remap ; in normal mode to commands
" nnoremap ; :Commands<cr>

" retain highlighted section after indentation
vnoremap > >gv
vnoremap < <gv

" tab/s-tab for menus
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" make the panel switches work in terminal mode
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <Esc> <C-\><C-n>

" set leader,
let mapleader=" "

nnoremap <leader>g :Rg<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>c :Commands<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>m :Lines<cr>
nnoremap <leader>x :q<cr>
" nnoremap <leader><leader> :
" vnoremap <leader><leader> :
" tnoremap <leader><leader> :

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Ale go to def
" nnoremap gd :ALEGoToDefinition<CR>

" nvim-lsp completions
nnoremap <leader>gd    :lua vim.lsp.buf.declaration()<cr>
nnoremap <leader><c-]> :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>k     :lua vim.lsp.buf.hover()<cr>
nnoremap <leader>gD    :lua vim.lsp.buf.implementation()<cr>
nnoremap <leader><c-k> :lua vim.lsp.buf.signature_help()<cr>
nnoremap <leader>1gD   :lua vim.lsp.buf.type_definition()<cr>
nnoremap <leader>gr    :lua vim.lsp.buf.references()<cr>
nnoremap <leader>g0    :lua vim.lsp.buf.document_symbol()<cr>
nnoremap <leader>gW    :lua vim.lsp.buf.workspace_symbol()<cr>

nnoremap <leader>j     :%!python -m json.tool<cr>
vnoremap <leader>j     :!python -m json.tool<cr>

" Command to toggle paste mode on and off
set pastetoggle=<leader>v

" set vim to ignore these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" replace silver searcher (AG) with ripgrep
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0)

" jumps for fzf
function! GetJumps()
  redir => cout
  silent jumps
  redir END
  return reverse(split(cout, "\n")[1:])
endfunction
function! GoToJump(jump)
    let jumpnumber = split(a:jump, '\s\+')[0]
    execute "normal " . jumpnumber . "\<c-o>"
endfunction
command! Jumps call fzf#run(fzf#wrap({
        \ 'source': GetJumps(),
        \ 'sink': function('GoToJump')}))

" use vscode undo stack when applicable
if exists('g:vscode')
    " Keep undo/redo lists in sync with VSCode
    nmap <silent> u <Cmd>call VSCodeNotify('undo')<CR>
    nmap <silent> <C-r> <Cmd>call VSCodeNotify('redo')<CR>
endif
