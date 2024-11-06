require "keymaps"
require "options"
require "Lazy"

vim.opt.termguicolors = true
vim.opt.list = true

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#212529 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#343A40 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#495057 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#6C757D gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#ADB5BD gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#CED4DA gui=nocombine]]
