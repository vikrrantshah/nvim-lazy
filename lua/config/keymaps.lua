-- Others
local function OpenUndotree()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end

vim.keymap.set("n", "<leader>ut", OpenUndotree, { desc = "[U]ndo [T]ree" })

vim.keymap.set("n", "<C-g>", "<cmd>Git<CR>5j", { desc = "Git" })

-- LSP
vim.keymap.set("n", "<leader>r", "", { desc = "+replace" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Name (Rename Symbol)" })

-- Move half page and center cursor to screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
