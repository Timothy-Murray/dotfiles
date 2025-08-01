local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>e", ":NvimTreeFocus<CR>", opts)
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
