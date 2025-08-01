require("core.options")
require("core.keymaps")
require("core.plugins")

-- Load plugin configs
require("plugins.lsp")
require("plugins.cmp")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.catppuccin")
require("nvim-tree").setup {}
