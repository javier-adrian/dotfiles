local M = {
    "hrsh7th/nvim-cmp",                        -- Autocomplete
    dependencies = {
        "hrsh7th/cmp-path",                    -- path completions
        "hrsh7th/cmp-cmdline",                 -- cmdline completions
        "hrsh7th/cmp-buffer",                  -- buffer completions
        "hrsh7th/cmp-nvim-lua",                -- NVIM Lua API completions
        "hrsh7th/cmp-nvim-lsp",                -- LSP completions
        "saadparwaiz1/cmp_luasnip",            -- integrates LuaSnip to nvim-cmp
        "L3MON4D3/LuaSnip",                    -- snippet engine (written in Lua, not for Lua)
        "rafamadriz/friendly-snippets",        -- general snippet collection
    },
    config = function()
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
    end
}

return M
