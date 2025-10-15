local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim" },
  { "neovim/nvim-lspconfig", version = "0.1.8", dependencies = {"hrsh7th/cmp-nvim-lsp",  commit = "5af77f54de1b16c34b23cba810150689a3a90312"} },
  { "hrsh7th/nvim-cmp", dependencies = {
        {"hrsh7th/cmp-nvim-lsp", commit = "5af77f54de1b16c34b23cba810150689a3a90312"},
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip"} },
  { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", commit = 'cfc6f2c', build = ":TSUpdate" },
  { "akinsho/toggleterm.nvim", version = "*", config = true}
})

