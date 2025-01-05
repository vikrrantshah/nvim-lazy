local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local function augroup_name(name)
  return "lazyvim_" .. name
end

local close_with_q = "close_with_q"
vim.api.nvim_del_augroup_by_name(augroup_name(close_with_q))

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup(close_with_q),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "snacks_win",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "fugitive",
    "undotree",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
