-- In your plugin configuration file (e.g., lua/plugins.lua or lua/plugins/init.lua)
return {
  {
    "numToStr/Comment.nvim",
    opts = {
      -- optional: customize options (will merge with defaults)
      padding = true,              -- add a space between comment and the line
      sticky  = true,              -- keep cursor at position
      ignore  = nil,               -- lines to ignore when commenting
      toggler = {
        line  = "gcc",             -- toggle line comment
        block = "gbc",             -- toggle block comment
      },
      opleader = {
        line  = "gc",              -- operator-pending line keymap
        block = "gb",              -- operator-pending block keymap
      },
      extra = {
        above = "gcO",             -- comment line above and enter insert mode
        below = "gco",             -- comment line below
        eol   = "gcA",             -- comment at end of line
      },
      mappings = {
        basic = true,             -- enable basic mappings: gcc, gbc, gc, gb
        extra = true,             -- enable extra mappings: gco, gcO, gcA
      },
      -- Example hooks for advanced use cases (optional):
      -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      -- post_hook = nil,
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
}

