return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Options: "latte", "frappe", "macchiato", "mocha"
        transparent_background = false, -- true if you want your terminal background
        integrations = {
          treesitter = true,
          nvimtree = true,
          telescope = true,
          cmp = true,
          lsp_trouble = true,
          mason = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

