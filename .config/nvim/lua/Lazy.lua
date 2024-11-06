local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable" .. lazypath})
end

vim.opt.rtp:prepend(lazypath)

local status_ok, _ = pcall(require, "lazy")
if not status_ok then
    vim.notify("Failed to load lazy.nvim.")
end

require("lazy").setup("plugins", {change_detection = {notify = false}})
