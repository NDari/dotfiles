-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- allow per-project configs
vim.o.exrc = true
-- exrc has security issues. this helps. nvim 0.9+ does not need this but
-- adding here just in case of an older version
vim.o.secure = true

-- keep things around
vim.opt.hidden = true

-- background
vim.opt.background = "dark"

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

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Decrease update time
vim.opt.updatetime = 250

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

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
    -- {
    --   "junegunn/fzf",
    --   build = "./install --bin"
    -- },
    -- {
    --   "ibhagwan/fzf-lua",
    --   -- optional for icon support
    --   dependencies = { "nvim-tree/nvim-web-devicons" },
    --   config = function()
    --     -- calling `setup` is optional for customization
    --     require("fzf-lua").setup({})
    --   end
    -- },

    -- toggle a terminal window
    -- {
    --   'akinsho/toggleterm.nvim',
    --   version = "*",
    --   config = true,
    -- },

    -- color schemes
    {
      "ellisonleao/gruvbox.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.cmd("colorscheme gruvbox")
      end,
    },
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
        auto_install = false,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = false, -- { 'ruby' },
        },
        indent = {
          enable = true,
        },
      },
      {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
          bigfile = { enabled = true },
          dashboard = { enabled = true },
          explorer = { enabled = true },
          indent = { enabled = true },
          input = { enabled = true },
          notifier = {
            enabled = true,
            timeout = 3000,
          },
          picker = { enabled = true },
          quickfile = { enabled = true },
          scope = { enabled = true },
          scroll = { enabled = true },
          statuscolumn = { enabled = true },
          words = { enabled = true },
          styles = {
            notification = {
              -- wo = { wrap = true } -- Wrap notifications
            }
          }
        },
        keys = {
          -- Top Pickers & Explorer
          { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
          { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
          { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
          { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
          { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
          -- find
          { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
          { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
          { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
          { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
          { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
          { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
          -- git
          { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
          { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
          { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
          { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
          { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
          { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
          { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
          -- Grep
          { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
          { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
          { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
          { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
          -- search
          { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
          { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
          { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
          { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
          { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
          { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
          { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
          { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
          { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
          { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
          { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
          { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
          { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
          { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
          { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
          { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
          { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
          { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
          { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
          { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
          { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
          -- LSP
          { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
          { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
          { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
          { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
          { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
          { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
          { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
          -- Other
          { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
          { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
          { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
          { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
          { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
          { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
          { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
          { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
          { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
          { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
          { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
          { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
          { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
          { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
          {
            "<leader>N",
            desc = "Neovim News",
            function()
              Snacks.win({
                file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                width = 0.6,
                height = 0.6,
                wo = {
                  spell = false,
                  wrap = false,
                  signcolumn = "yes",
                  statuscolumn = " ",
                  conceallevel = 3,
                },
              })
            end,
          }
        },
        init = function()
          vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
              -- Setup some globals for debugging (lazy-loaded)
              _G.dd = function(...)
                Snacks.debug.inspect(...)
              end
              _G.bt = function()
                Snacks.debug.backtrace()
              end
              vim.print = _G.dd -- Override print to use snacks for `:=` command

              -- Create some toggle mappings
              Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
              Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
              Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
              Snacks.toggle.diagnostics():map("<leader>ud")
              Snacks.toggle.line_number():map("<leader>ul")
              Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
              Snacks.toggle.treesitter():map("<leader>uT")
              Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
              Snacks.toggle.inlay_hints():map("<leader>uh")
              Snacks.toggle.indent():map("<leader>ug")
              Snacks.toggle.dim():map("<leader>uD")
            end,
          })
        end,
      },
      {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        },
        keys = {
          {
            "<leader>?",
            function()
              require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
          },
        },
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
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
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

-- vim.keymap.set("n", "<leader>b", '<cmd>lua require("fzf-lua").buffers()<CR>', {})
-- vim.keymap.set("n", "<leader>q", '<cmd>lua require("fzf-lua").quickfix()<CR>', {})
-- vim.keymap.set("n", "<leader>f", '<cmd>lua require("fzf-lua").files()<CR>', {})
-- vim.keymap.set("n", "<leader>", '<cmd>lua require("fzf-lua").live_grep_glob()<CR>', {})
-- vim.keymap.set("n", "<leader>r", '<cmd>lua require("fzf-lua").grep_project()<CR>', {})
-- vim.keymap.set("n", "<leader>", '<cmd>lua require"fzf-lua".help_tags()<CR>', {})

-- local toggleterm = require("toggleterm")
-- toggleterm.setup({
--   size = 20,
--   open_mapping = [[<leader>`]],
--   hide_numbers = true,
--   shade_filetypes = {},
--   shade_terminals = true,
--   shading_factor = 2,
--   start_in_insert = true,
--   insert_mappings = true,
--   persist_size = true,
--   direction = "float",
--   close_on_exit = true,
--   shell = vim.o.shell,
--   float_opts = {
--     border = "curved",
--     winblend = 0,
--     highlights = {
--       border = "Normal",
--       background = "Normal",
--     },
--   },
-- })
-- function _G.set_terminal_keymaps()
--   local opts = { noremap = true }
--   vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
-- end

-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
