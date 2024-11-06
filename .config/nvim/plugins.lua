local function check (packageName)
    local status_ok, _ = pcall(require, packageName)
    if not status_ok then
        vim.notify("Failed to load" .. packageName .. ".")
    end
end
---------------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable" .. lazypath})
end

vim.opt.rtp:prepend(lazypath)

check("lazy")
---------------------------------------------------------------------------------------------------
require("lazy").setup({
---------------------------------------------------------------------------------------------------
    { "catppuccin/nvim",     priority = 1000 },    -- Catppuccin colorscheme
    { "Mofiqul/vscode.nvim", priority = 1000 },    -- VSCode colorscheme

    "nvim-tree/nvim-web-devicons",                 -- Icons
    "nvim-lualine/lualine.nvim",                   -- Statusline
    "lewis6991/gitsigns.nvim",                     -- Git signcolumn decorations
    "lukas-reineke/indent-blankline.nvim",         -- Indentation and spacing guides
    "petertriho/nvim-scrollbar",                   -- Scrollbar
    "nvim-tree/nvim-tree.lua",                     -- File explorer
    "numToStr/Comment.nvim",                       -- Comment keybinds
    "folke/which-key.nvim",                        -- Keybind helper

    {   "nvim-treesitter/nvim-treesitter",         -- Language-parser, syntax highlighting
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        build = ":TSUpdate"
    },
    {   "hrsh7th/nvim-cmp",                        -- Autocomplete
        dependencies = {
            "hrsh7th/cmp-path",                    -- path completions
            "hrsh7th/cmp-cmdline",                 -- cmdline completions
            "hrsh7th/cmp-buffer",                  -- buffer completions
            "hrsh7th/cmp-nvim-lsp",                -- LSP completions
            "saadparwaiz1/cmp_luasnip",            -- integrates LuaSnip to nvim-cmp
            "L3MON4D3/LuaSnip",                    -- snippet engine (written in Lua, not for Lua)
            "rafamadriz/friendly-snippets",        -- general snippet collection
            "hrsh7th/cmp-nvim-lua",                -- NVIM Lua API completions
        }
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
    {   "neovim/nvim-lspconfig",                   -- LSP Configuration & Plugins
        dependencies = {
            {   "williamboman/mason.nvim",         -- LSP Manager
                config = true
            },
            "williamboman/mason-lspconfig.nvim",   -- Automatically configures LSP on install
            {   "j-hui/fidget.nvim",               -- LSP status updates
                tag = "legacy",
                opts = {}
            },
            "folke/neodev.nvim",                   -- NVIM Lua LSP
        },
    },
})

-- NOTE: `opts = {}` and `config = true` is the same as `require("fidget").setup({})`, and
--       `config = function() ... end` is the same as `require("fidget").setup({...})`

--       `opts` is `require("fidget").setup({...})` but you can only set variables since it's a table
--       `config` is syntactically `require("fidget").setup({...})` but done in plugin specs

--       `config` is basically for executing vim commands when the plugin is loaded
---------------------------------------------------------------------------------------------------
-- nvim-scrollbar

require("scrollbar").setup{ handle = { color = "#666666" } }
---------------------------------------------------------------------------------------------------
-- which-key

require("which-key").setup()
---------------------------------------------------------------------------------------------------
-- Comment

require("Comment").setup{
    extra = {
      eol = "gca",
    }
}
---------------------------------------------------------------------------------------------------
-- nvim-treesitter

require("nvim-treesitter.configs").setup{
    ensure_installed = {"c", "cpp", "lua", "python", "gdscript", "html", "javascript", "css"},
    auto_install = false, -- Automatically install languages being edited
    highlight = {enable = true}
}
---------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------
-- nvim-tree

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<CR>", {desc = "[B]rowse"})
---------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------
-- catppuccin

require("catppuccin").setup {
    flavour = "mocha",
    term_colors = true,
    color_overrides = {
        mocha = {
            base = "#080910",
            mantle = "#101220",
            crust = "#080910",
        }
    },
    integrations = {
        treesitter = true,
        nvimtree = true,
        telescope = {enabled = true}
    }
}

-- vim.cmd.colorscheme "catppuccin-mocha"
---------------------------------------------------------------------------------------------------
-- vscode.nvim

require("vscode").setup{}
require("vscode").load("dark")

-- vim.cmd.colorscheme "vscode"
---------------------------------------------------------------------------------------------------
-- lualine

require("lualine").setup{
    options = {
        -- theme = "catppuccin-mocha",
        theme = "vscode",
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {"buffers"},                       -- {"mode"}
        lualine_b = {},                                -- {"branch", "diff", "diagnostics"}
        lualine_c = {},                                -- {"filename"}
        lualine_x = {"branch", "diff", "diagnostics"}, -- {"encoding", "fileformat", "filetype"}
        lualine_y = {"filetype"},                      -- {"progress"}
        lualine_z = {"location", "progress"}           -- {"location"}
    },
}
---------------------------------------------------------------------------------------------------
-- indent-blankline

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#212529 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#343A40 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#495057 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#6C757D gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#ADB5BD gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#CED4DA gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent3"
    },
    show_trailing_blankline_indent = true,
    show_current_context = true,
    show_current_context_start = false,
    char = "▏"
}
---------------------------------------------------------------------------------------------------
-- nvim-cmp (whooole lotta copypasta after this line. need to study cmp, lsp, telescope, NVIMtree)

local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

local kind_icons = {
    Text = "󰊄",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰫧",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "󰌆",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "󰉺",
}

cmp.setup({
    enabled = true,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
          end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                luasnip = "[Snippet]",
                nvim_lua = "[nvim_lua]",
                path = "[Path]",
            })[entry.source.name]

            return vim_item
        end,
    },
    experimental = {
        ghost_text = true
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
    {
        { name = "path" }
    },
    {
        { name = "cmdline" }
    })
})
---------------------------------------------------------------------------------------------------
-- lsp

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don"t have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    underline = false,
    virtual_text = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property "filetypes" to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { "html", "twig", "hbs"} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {disable = {"missing-fields", "missing-parameter"}}
    },
  },
}

require"lspconfig".gdscript.setup{}


-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         virtual_text = true,
--         signs = true,
--         update_in_insert = false,
--         underline = false
--     }
-- )
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
