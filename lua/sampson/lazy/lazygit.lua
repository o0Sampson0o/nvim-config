return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "LazyGit" },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
    },
    config = function()
        vim.g.lazygit_floating_window_winblend = 0     -- transparency
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- size
        vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    end,
}
