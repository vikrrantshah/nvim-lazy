return {
  { "echasnovski/mini.pairs", opts = { skip_ts = { "string", "function" } } },
  { "folke/which-key.nvim", opts = { preset = "classic" } },
  { "neovim/nvim-lspconfig", opts = { inlay_hints = { enable = false } } },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
            ▄▄██████████▄▄            
            ▀▀▀   ██   ▀▀▀            
    ▄██▄   ▄▄████████████▄▄   ▄██▄    
  ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄  
 ████▄ ▄███▀              ▀███▄ ▄████ 
███▀█████▀▄████▄      ▄████▄▀█████▀███
██▀  ███▀ ██████      ██████ ▀███  ▀██
 ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀ 
    ███           ▀▀           ███    
    ██████████████████████████████    
▄█  ▀██  ███   ██    ██   ███  ██▀  █▄
███  ███ ███   ██    ██   ███▄███  ███
▀██▄████████   ██    ██   ████████▄██▀
 ▀███▀ ▀████   ██    ██   ████▀ ▀███▀ 
  ▀███▄  ▀███████    ███████▀  ▄███▀  
    ▀███    ▀▀██████████▀▀▀   ███▀    
      ▀    ▄▄▄    ██    ▄▄▄    ▀      
            ▀████████████▀            
]],
          keys = {
            { icon = " ", key = "f", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "p", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
