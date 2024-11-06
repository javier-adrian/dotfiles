require("lazy").setup({
    "lewis6991/gitsigns.nvim",                     -- Git signcolumn decorations
    "nvim-tree/nvim-tree.lua",                     -- File explorer

    {   "nvim-treesitter/nvim-treesitter",         -- Language-parser, syntax highlighting
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        build = ":TSUpdate"
    },
    {   "nvim-telescope/telescope.nvim",           -- Fuzzy find
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {   "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                  return vim.fn.executable "make" == 1
                end,
            },
        },
    },
})

-- nvim-treesitter

require("nvim-treesitter.configs").setup{
    ensure_installed = {"c", "cpp", "lua", "python", "gdscript", "html", "javascript", "css"},
    auto_install = false, -- Automatically install languages being edited
    highlight = {enable = true}
}

-- gitsigns

require("gitsigns").setup{
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 0
    },
    signs = {
        add = {text = "▏"}
    }
}

-- nvim-tree

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<CR>", {desc = "[B]rowse"})

-- telescope

require("telescope").setup()
pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
