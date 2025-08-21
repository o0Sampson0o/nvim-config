return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup()
    vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Stage hunk" })
    vim.keymap.set('n', '<leader>hb', ':Gitsigns blame_line<CR>', { desc = "Blame line" })
    vim.keymap.set('n', ']c', function() require("gitsigns").nav_hunk("next") end, { desc = "Next hunk" })
    vim.keymap.set('n', '[c', function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev hunk" })
  end,
}
