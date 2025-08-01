require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "python", "javascript" },
  highlight = { enable = true },
  indent = { enable = true },
})
