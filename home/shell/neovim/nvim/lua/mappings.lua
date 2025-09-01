require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Keep visual selection after indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- go back to last buffer when inside NvimTree
vim.keymap.set("n", "<leader>b", "<C-w>p", { noremap = true, silent = true })
