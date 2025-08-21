-- Set leader key before Lazy
vim.g.mapleader = " "

-- Load plugins (this loads everything in lua/sampson/lazy/)
require("sampson.lazy_init")

-- Telescope keymaps (only if telescope is available)
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search text" })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List buffers" })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
end

-- NvimTree keymap (toggle file explorer)
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', { desc = "Toggle file explorer" })
vim.opt.number = true
-- Set indentation defaults
vim.o.tabstop = 4      -- Number of spaces that a <Tab> counts for
vim.o.shiftwidth = 4   -- Number of spaces for each indent level
vim.o.expandtab = true -- Convert tabs to spaces (so no real tabs)
vim.o.smartindent = true -- Auto-indent new lines
