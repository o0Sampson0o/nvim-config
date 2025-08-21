return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gstatus", "Gdiff", "Gblame" },
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git status (Fugitive)" },
  },
}

