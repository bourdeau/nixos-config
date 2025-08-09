require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Keep visual selection after indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
