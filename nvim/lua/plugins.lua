return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local api = require("nvim-tree.api")

      local function dir_of(node)
        if not node then return nil end
        if node.type == "directory" then return node.absolute_path end
        return vim.fn.fnamemodify(node.absolute_path, ":h")
      end

      require("nvim-tree").setup({
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr) -- keep all defaults

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- terminal inside nvim, in a split
          vim.keymap.set("n", "<leader>t", function()
            local dir = dir_of(api.tree.get_node_under_cursor())
            if not dir then return end
            vim.cmd("botright split | resize 15")
            vim.cmd("lcd " .. vim.fn.fnameescape(dir))
            vim.cmd("terminal")
            vim.cmd("startinsert")
          end, opts("terminal split here"))

          -- new Ghostty window at that directory
          vim.keymap.set("n", "<leader>T", function()
            local dir = dir_of(api.tree.get_node_under_cursor())
            if not dir then return end
            vim.system({ "open", "-na", "Ghostty", "--args", "--working-directory=" .. dir })
          end, opts("Ghostty window here"))
        end,
      })
    end,
  },
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    if
      vim.env.TERM_PROGRAM == "ghostty"
      or vim.env.GHOSTTY_BIN_DIR
      or vim.env.GHOSTTY_RESOURCES_DIR
      or vim.env.__CFBundleIdentifier == "com.mitchellh.ghostty"
    then
      vim.env.SNACKS_GHOSTTY = "true"
    end
  end,
  opts = {
    -- Enable the image module
    image = {
      enabled = true,
      convert = {
        notify = true,
      },
      doc = {
        -- This displays images inline inside markdown files
        inline = true,
        -- Only renders the image when your cursor is near it
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
    -- Needed so image conversion failures actually surface instead of
    -- silently spinning forever.
    notifier = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- tmux doesn't report pixel dimensions, so the TIOCGWINSZ ioctl in
    -- snacks/image/terminal.lua returns xpixel/ypixel = 0. Its guard only
    -- rejects col/row == 0, so those zeros overwrite the built-in 9x18
    -- fallback. Cell size 0 then makes pixels_to_cells() divide by zero
    -- (inf), fit() compute inf/inf (nan), and the image never renders --
    -- it just spins with no error. Restore a sane fallback.
    local terminal = require("snacks.image.terminal")
    local size = terminal.size
    terminal.size = function()
      local s = size()
      if not s.cell_width or s.cell_width == 0 or s.cell_height == 0 then
        local cw, ch = 9, 18
        s.cell_width, s.cell_height = cw, ch
        s.width, s.height = s.columns * cw, s.rows * ch
        s.scale = math.max(1, cw / 8)
      end
      return s
    end

    vim.api.nvim_create_user_command("SnacksImageDebug", function()
      vim.print({
        supports_terminal = require("snacks.image").supports_terminal(),
        env = terminal.env(),
        terminal = terminal._terminal,
        size = terminal.size(),
        TERM = vim.env.TERM,
        TERM_PROGRAM = vim.env.TERM_PROGRAM,
        TMUX = vim.env.TMUX,
        SNACKS_GHOSTTY = vim.env.SNACKS_GHOSTTY,
      })
    end, {})
  end,
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
