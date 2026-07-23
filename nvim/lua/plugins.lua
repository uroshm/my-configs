return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enable the image module
    image = {
      enabled = true,
      doc = {
        -- This displays images inline inside markdown files
        inline = true, 
        -- Only renders the image when your cursor is near it
        float = true,  
        max_width = 80,
        max_height = 40,
      },
    },
  },
},
{
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required (already used by telescope)
    "sindrets/diffview.nvim", -- optional: rich diff view
    "nvim-telescope/telescope.nvim", -- optional: use telescope for pickers
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", function() require("neogit").open() end, desc = "Neogit: [G]it status" },
    { "<leader>gc", function() require("neogit").open({ "commit" }) end, desc = "Neogit: [C]ommit" },
    { "<leader>gp", function() require("neogit").open({ "pull" }) end, desc = "Neogit: [P]ull" },
    { "<leader>gP", function() require("neogit").open({ "push" }) end, desc = "Neogit: [P]ush" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Neogit: [B]ranches" },
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
},
{
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: [D]iff working tree" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: close [D]iff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo [H]istory" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: [F]ile history" },
    { "<leader>gd", ":'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Diffview: history of selection" },
  },
  opts = {},
}
}
