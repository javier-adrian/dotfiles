local M = {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function ()
        require("vscode").load("dark") -- this seems very backwards but ok
    end
}

return M
