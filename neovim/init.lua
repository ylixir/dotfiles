-- without this, the terminal will open in bash, not fish
vim.env.FISHLVL = ''

vim.opt.guifont = "Ellograph CF:h12"
vim.opt.termguicolors = true
vim.opt.showtabline = 2 -- 2 means always show tabs
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars:append("tab:├─")
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.mouse = "a" -- hold shift to disable (aka for pasting in windows terminal)
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.title = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
--[[ theory: these are causing a ruckus with autocomplete
-- fix if true: https://jdhao.github.io/2020/11/23/neovim_better_mapping_for_leaving_insert_mode/
vim.api.nvim_set_keymap("i", ",,", "<c-o>m`<c-o>A,<c-o>``", { noremap = true })
vim.api.nvim_set_keymap("i", ";;", "<c-o>m`<c-o>A;<c-o>``", { noremap = true })
]]
-- vim.api.nvim_set_keymap("i", "<s-tab>", vim.fn.pumvisible() and "<c-p>" or "<s-tab>", {noremap=true, expr=true})
-- vim.api.nvim_set_keymap("i", "<tab>", vim.fn.pumvisible() and "<c-n>" or "<tab>", {noremap=true, expr=true})
vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", { noremap = true })
vim.api.nvim_set_keymap("t", "<c-_>", "<c-\\><c-n>", { noremap = true }) -- c-_ is the same as c-/
-- these are back/forward mouse buttons not to be confused with left/rightmous
vim.api.nvim_set_keymap("n", "<m-left>", "<c-o>", { noremap = true })
vim.api.nvim_set_keymap("n", "<m-right>", "<c-i>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-o>", ":vs<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-u>", ":sp<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-t>", ":te<cr>i", { noremap = true })
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr><esc>", { noremap = true }) -- hide last search

-- lsp mappings
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- highlight word under cursor
  require('illuminate').on_attach(client)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>w", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, silent = true })

  --[[ some unused examples
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {noremap=true, silent=true})
  ]]
end

-- plugin keymaps
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>a", '"zy:lua require("telescope.builtin").live_grep({default_text="<C-r>z"})<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>E", "<cmd>lua vim.diagnostic.goto_next()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').git_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>F", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":Bwipeout<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua require('telescope.builtin').pickers()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":SessionManager load_session<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeFindFileToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":Neotree toggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<silent> <leader>", ":WhichKey '<space>'<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>v", ":Vista!!<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>v", ":SymbolsOutline<cr>", { noremap = true, silent = true })

-- autocomplet mappings
--[[
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
]]

require "paq" {
  -- "savq/paq-nvim"; -- PaqSync, this plugin is managed in flake.nix

  "nvim-lua/plenary.nvim"; -- dependency for many plugins
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" };

  "L3MON4D3/LuaSnip"; -- mostly here to make nvim-cmp happy
  "MunifTanjim/nui.nvim"; -- neo-tree needs this
  "NMAC427/guess-indent.nvim"; -- guess auto indent settings
  "RRethy/vim-illuminate";
  "Shatur/neovim-session-manager";
  "SmiteshP/nvim-gps";
  "arkav/lualine-lsp-progress";
  "direnv/direnv.vim";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-cmdline";
  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/cmp-path";
  "hrsh7th/nvim-cmp";
  "jose-elias-alvarez/null-ls.nvim";
  "kyazdani42/nvim-web-devicons";
  "lewis6991/gitsigns.nvim";
  "lukas-reineke/indent-blankline.nvim"; -- show vertical indent lines
  "moll/vim-bbye";
  "neovim/nvim-lspconfig";
  "norcalli/nvim-colorizer.lua";
  "nvim-lualine/lualine.nvim";
  "nvim-neo-tree/neo-tree.nvim";
  "nvim-telescope/telescope-ui-select.nvim";
  "nvim-telescope/telescope.nvim";
  "p00f/nvim-ts-rainbow";
  "saadparwaiz1/cmp_luasnip";
  "simrat39/symbols-outline.nvim";
  "tpope/vim-fugitive"; -- maybe neogit and/or gitsigns can replace this? it's just not discoverable

  -- colorschemes
  --"mcchrish/zenbones.nvim";
  --"rktjmp/lush.nvim"; -- used by zenbones
  { "catppuccin/nvim", as = "catppuccin" };
}

local cmp = require("cmp") -- autocompletion
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = 'buffer' }
  },
  mapping = {
    ['<tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  },
}
-- this is annoying
--[[
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
]]
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("colorizer").setup({ '*' }, { css = true })

require("gitsigns").setup {
  current_line_blame = true,
}
require("guess-indent").setup {}
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

vim.opt.background = "dark"
vim.cmd("colorscheme catppuccin-macchiato")

for _, lsp in pairs { "rnix", "solargraph", "angularls", "purescriptls", "rust_analyzer" } do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig').eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "html" }
}

require('lspconfig').tsserver.setup { -- lua needs extra config to make it shut up about vim not being defined
  on_attach = function(client, bufnr)
    -- avoid conflicts between prettier and tsserver
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

require('lspconfig').volar.setup { -- lua needs extra config to make it shut up about vim not being defined
  on_attach = function(client, bufnr)
    -- avoid conflicts between prettier and tsserver
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

require('lspconfig').lua_ls.setup { -- lua needs extra config to make it shut up about vim not being defined
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

require('lualine').setup {
  options = { theme = "catppuccin" },
  sections = {
    lualine_a = { 'diff' },
    lualine_b = {},
    lualine_c = {
      'lsp_progress',
      {
        require('nvim-gps').get_location,
        cond = require('nvim-gps').is_available
      },
    },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    -- would be nice fo have filename and filetyep together like in the buffers
    lualine_a = {
      -- { 'filetype', icon_only = true },
      { 'fileformat', separator = '' },
      { 'encoding', separator = '' },
      -- { 'filename' }
    },
    lualine_b = { 'buffers' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'branch' },
    lualine_z = { 'tabs' }
  },
  --  extensions = { 'nvim-tree', 'fugitive' },
  extensions = { 'fugitive' },
}

vim.g.neo_tree_remove_legacy_commands = 1
require("neo-tree").setup {
  filesystem = {
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
}
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.formatting.prettier
    null_ls.builtins.formatting.prettierd.with({
      disabled_filetypes = { "lua" },
    }),
  },
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end
})

require('nvim-gps').setup {}

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}

require('session_manager').setup {
  autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
}
require("telescope").setup {}
require("telescope").load_extension("ui-select")
