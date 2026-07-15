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
}
}
