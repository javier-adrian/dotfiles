local M = {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            -- theme = "gruvchad",
            icons_enabled = true,
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        },
        sections = {
            lualine_c = {
                -- {
                --     "filename",
                --     path = 2,
                --     symbols = {
                --         modified = "󰏫",
                --         readonly = "",
                --         unnamed = "",
                --         newfile = "󰈙",
                --     }
                -- }
            },

            lualine_x = {
                "searchcount"
            },

            lualine_y = {
                -- "filetype"
            },

            lualine_z = {
                "location",
                "progress"
            }
        },
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    show_filename_only = false,
                    hide_filename_extension = false,
                    show_modified_status = true
                },
            },
        },
    }
}

return M
