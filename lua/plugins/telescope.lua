return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  enabled = function()
    return LazyVim.pick.want() == "telescope"
  end,
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (build_cmd ~= "cmake") and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = build_cmd ~= nil,
      config = function(plugin)
        LazyVim.on_load("telescope.nvim", function()
          local ok, err = pcall(require("telescope").load_extension, "fzf")
          if not ok then
            local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
            if not vim.uv.fs_stat(lib) then
              LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
              require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
              end)
            else
              LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
            end
          end
        end)
      end,
    },
  },
  keys = {
    -- Files
    { "<C-p>", LazyVim.pick("files"), desc = "Search Files" },
    { "<leader>sf", LazyVim.pick("files"), desc = "Search Files" },
    { "<leader><leader>", LazyVim.pick("buffers"), desc = "Find buffers" },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
    -- Grep
    { "<C-f>", LazyVim.pick("live_grep"), desc = "Search Grep Globally" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Grep in Buffer" },
    { "<leader>sg", LazyVim.pick("live_grep"), desc = "Search Grep Globally" },
    -- Word Grep
    { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Search Grep Word" },
    { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Search Grep Word & Select" },
    -- Commands
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Search Command History" },
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
    -- Git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
    -- Registers
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    -- Auto Commands
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Search Auto Commands" },
    -- Diagnostics
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Search Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Search Workspace Diagnostics" },
    -- Help
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Pages" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Search Man Pages" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Vim Options" },
    -- Lists
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Search Location List" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Search Marks & Jump" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Search Quickfix List" },
    -- Symbols
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
    -- Others
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
