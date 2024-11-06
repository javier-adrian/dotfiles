local opts = {noremap = true, silent = true}
local term_opts = {silent = true}

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab navigation
keymap("n", "<A-j>", ":tabprevious<CR>", opts)
keymap("n", "<A-k>", ":tabnext<CR>", opts)
-- keymap("n", "<A-j>", ":bprevious<CR>", opts)
-- keymap("n", "<A-k>", ":bnext<CR>", opts)
keymap("n", "<A-t>", ":tabedit ", opts)

-- Active split navigation
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)

-- File explorer
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

keymap("n", "<C-s>", ":w<CR>", opts)

-- Move text up and down
keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap("n", "<A-Down>", ":m .+1<CR>==", opts)
