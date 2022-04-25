-- without this, the terminal will open in bash, not fish
vim.env.FISHLVL=''

require "paq" {
  -- "savq/paq-nvim"; -- PaqSync, this plugin is managed in flake.nix
  "NMAC427/guess-indent.nvim";
}

vim.opt.showtabline = 2 -- 2 means always show tabs
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = "tab:├─"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.mouse = "a" -- hold shift to disable (aka for pasting in windows terminal)
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
require("guess-indent").setup {}

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", ",,", "<c-o>m`<c-o>A,<c-o>``", {noremap=true})
vim.api.nvim_set_keymap("i", ";;", "<c-o>m`<c-o>A;<c-o>``", {noremap=true})
vim.api.nvim_set_keymap("i", "<s-tab>", vim.fn.pumvisible() and "<c-p>" or "<s-tab>", {noremap=true, expr=true})
vim.api.nvim_set_keymap("i", "<tab>", vim.fn.pumvisible() and "<c-n>" or "<tab>", {noremap=true, expr=true})
vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", {noremap=true})
vim.api.nvim_set_keymap("t", "<c-_>", "<c-\\><c-n>", {noremap=true}) -- c-_ is the same as c-/
vim.api.nvim_set_keymap("n", "<c-a>", "<c-o>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-o>", ":vs<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-u>", ":sp<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<c-t>", ":te<cr>i", {noremap=true})

-- plugin keymaps
-- vim.api.nvim_set_keymap("n", "<silent> <leader>q", ":Bdelete<CR>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>", ":WhichKey '<space>'<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <leader>v", ":Vista!!<cr>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<silent> <expr> <leader>t", g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>", {noremap=true})
