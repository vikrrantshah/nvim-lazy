-- Clean up search highligh by pressing ESC
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move vertically and center cursor to screen
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")

-- Move half page and center cursor to screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer movements
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bNext, { desc = "[B]uffer [P]revious" })

-- LSP
vim.keymap.set("n", "<leader>l", vim.lsp.buf.hover, { desc = "LSP" })
vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, { desc = "Get Info about element under cursor" })
vim.keymap.set("n", "<leader>r", "", { desc = "+replace" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Name (Rename Symbol)" })

-- Others
local function OpenUndotree()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end

vim.keymap.set("n", "<leader>ut", OpenUndotree, { desc = "[U]ndo [T]ree" })

vim.keymap.set("n", "<C-g>", "<cmd>Git<CR>5j", { desc = "Git" })
