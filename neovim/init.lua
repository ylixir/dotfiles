-- without this, the terminal will open in bash, not fish
vim.env.FISHLVL=''

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

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", ",,", "<c-o>m`<c-o>A,<c-o>``", {noremap=true})
vim.api.nvim_set_keymap("i", ";;", "<c-o>m`<c-o>A;<c-o>``", {noremap=true})
-- vim.api.nvim_set_keymap("i", "<s-tab>", vim.fn.pumvisible() and "<c-p>" or "<s-tab>", {noremap=true, expr=true})
-- vim.api.nvim_set_keymap("i", "<tab>", vim.fn.pumvisible() and "<c-n>" or "<tab>", {noremap=true, expr=true})
vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", {noremap=true})
vim.api.nvim_set_keymap("t", "<c-_>", "<c-\\><c-n>", {noremap=true}) -- c-_ is the same as c-/
vim.api.nvim_set_keymap("n", "<c-a>", "<c-o>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-o>", ":vs<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-u>", ":sp<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-t>", ":te<cr>i", {noremap=true})
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr><esc>", {noremap=true}) -- hide last search

-- lsp mappings
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', {noremap=true, silent=true})
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {noremap=true, silent=true})
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>w', '<cmd>lua vim.lsp.buf.formatting()<cr>', {noremap=true, silent=true})
end

-- plugin keymaps
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeFindFileToggle<cr>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>q", ":Bdelete<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>", ":WhichKey '<space>'<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>v", ":Vista!!<cr>", {noremap=true})

require "paq" {
  -- "savq/paq-nvim"; -- PaqSync, this plugin is managed in flake.nix

  "nvim-lua/plenary.nvim"; -- dependency for many plugins
  {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"};

  "L3MON4D3/LuaSnip"; -- mostly here to make nvim-cmp happy
  "NMAC427/guess-indent.nvim"; -- guess auto indent settings
  "direnv/direnv.vim";
  "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-path";
    "saadparwaiz1/cmp_luasnip";
  "kyazdani42/nvim-tree.lua";
  "lewis6991/gitsigns.nvim";
  "lukas-reineke/indent-blankline.nvim"; -- show vertical indent lines
  "neovim/nvim-lspconfig";
  "nvim-telescope/telescope.nvim";
  "tpope/vim-fugitive"; -- maybe neogit and/or gitsigns can replace this? it's just not discoverable
}

require("guess-indent").setup {}
require("nvim-tree").setup {}
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}
require("telescope").setup {}
require("gitsigns").setup {
  current_line_blame = true,
}

-- autocompletion
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources {
    {name = "nvim_lsp"},
    {name = "luasnip"},
  }, {
    {name='buffer'}
  },
}
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in pairs {"rnix", "solargraph", "tsserver", "vuels", "angularls"} do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lua needs extra config to make it shut up about vim not being defined
require('lspconfig').sumneko_lua.setup {
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
