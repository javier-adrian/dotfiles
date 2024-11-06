vim.o.termguicolors = true      -- Use 24-bit RGB
vim.wo.number = true            -- Show line numbers
vim.wo.signcolumn = "yes"       -- Draw column dedicated for signs
vim.o.colorcolumn = "100"       -- Margin
vim.o.showmode = false          -- Indicate mode
vim.o.scrolloff = 8             -- Minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8         -- Same as scrolloff but for the horizontal axis
vim.o.cursorline = false        -- Highlight current line
vim.o.showtabline = 0           -- Show tabs (0-never|1->=2 tabs|2-always)

vim.o.shiftwidth = 4            -- Set number of spaces for indents
vim.o.autoindent = true         -- Indent based on context
vim.o.smartindent = true        -- Detect indent length of file
vim.o.breakindent = false       -- Align indentation of wrapped lines to the beginning of the line
vim.o.expandtab = false         -- Tabs are converted to spaces
vim.o.tabstop = 4               -- How many spaces are inserted when Tab is inputted

vim.o.hlsearch = false          -- Highlight all search pattern matches
vim.o.ignorecase = true         -- Ignore case in search patterns
vim.o.smartcase = true          -- Override ignorecase if pattern contains uppercase characters

vim.o.mouse = "a"               -- Enable mouse support for all modes
vim.o.clipboard = "unnamedplus" -- Sync clipboard betweeen Neovim and OS
vim.o.undofile = true           -- Make an undo file

vim.o.updatetime = 250          -- Update swap every <value in ms> idle time
vim.o.timeoutlen = 300          -- Time (in ms) to wait for a mapped sequence to complete

vim.o.completeopt = "menuone,noselect" -- Code completion behavior

