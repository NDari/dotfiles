-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- make backspace act right
vim.opt.backspace:append({ "indent", "eol", "start" })

-- mostly for markdown
vim.opt.conceallevel = 2

-- indent
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- keep things around
vim.opt.hidden = true

-- search configs
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- sane splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- scroll a bit extra when at the bottom/top of the page
vim.opt.scrolloff = 15

-- mouse support
vim.opt.mouse = "a"

-- enable 24bit RGB colors
vim.opt.termguicolors = true

-- completions to use menu and not preview
vim.opt.completeopt = 'menu'

-- line numbers
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cmdheight = 1
vim.cmd("set noshowmode")
-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- keybindings
-- Moving between splits
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("n", "<C-h>", "<C-W>h")
-- and terminal
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")


-- .vimrc access and source
vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<CR>")
-- vim.keymap.set("n", "<leader>sv", ":Lazy sync<CR>")

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

-- paste over selection without copying the selection to clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yanking a line should act like D and C
vim.keymap.set('n', 'Y', 'y$')

-- retain highlighted section after indenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- lsp
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "williamboman/mason.nvim" },           -- for installing things
    { "williamboman/mason-lspconfig.nvim" }, -- for installing lsp
    { "hrsh7th/cmp-buffer" },                -- completions from the buffers
    { "hrsh7th/cmp-path" },                  -- completion for paths
    { "hrsh7th/cmp-cmdline" },               -- vim command completions

    -- add pairs automatically
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    -- []q quickfix, []b buffers, []a file
    { "tpope/vim-unimpaired" },

    -- yank/change in pairs
    { "tpope/vim-surround" },

    -- comment lines
    { "tpope/vim-commentary" },

    -- file system with -
    { "tpope/vim-vinegar" },

    -- readline keybinds in insert mode
    { "tpope/vim-rsi" },

    -- fzf stuff
    -- install fzf if we dont have it.
    {
      "junegunn/fzf",
      build = "./install --bin"
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    },

    -- toggle a terminal window
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      config = true,
    },

    -- color schemes
    { "sainnhe/gruvbox-material" },
    -- send code to repl
    -- {
    --   "jpalardy/vim-slime",

    --   config = function()
    --     vim.g.slime_target = "neovim"
    --     vim.g.slime_bracketed_paste = 1
    --     vim.g.slime_suggest_default = 1
    --     -- vim.cmd([[let g:slime_default_config = {"pane_direction": "right"}]])
    --   end,
    -- },

    -- statusline
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("lualine").setup({
          options = {
            icons_enabled = true,
          },
          sections = {
            lualine_c = {
              {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
              }
            }
          }
        })
      end,
    },

    -- treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      main = 'nvim-treesitter.configs', -- Sets main module to use for opts
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      opts = {
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'python',
          'sql',
          'query',
          'ruby',
          'vim',
          'vimdoc',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      },
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },


  },
  -- Configure any other settings here. See the documentation for more details.
})

-- pluging configs
vim.cmd("colorscheme gruvbox-material")

-- lsp configs
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
require("mason").setup()
require("mason-lspconfig").setup()

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- These are example language servers.
require('lspconfig').julials.setup({})
require('lspconfig').pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  }
})
require('lspconfig').solargraph.setup({})
require('lspconfig').lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.keymap.set("n", "<leader>b", '<cmd>lua require("fzf-lua").buffers()<CR>', {})
vim.keymap.set("n", "<leader>q", '<cmd>lua require("fzf-lua").quickfix()<CR>', {})
vim.keymap.set("n", "<leader>f", '<cmd>lua require("fzf-lua").files()<CR>', {})
-- vim.keymap.set("n", "<leader>", '<cmd>lua require("fzf-lua").live_grep_glob()<CR>', {})
vim.keymap.set("n", "<leader>r", '<cmd>lua require("fzf-lua").grep_project()<CR>', {})
-- vim.keymap.set("n", "<leader>", '<cmd>lua require"fzf-lua".help_tags()<CR>', {})

local toggleterm = require("toggleterm")
toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
