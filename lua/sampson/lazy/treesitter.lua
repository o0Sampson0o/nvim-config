return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "elixir",
                "javascript",
                "html",
                "python",
                "typescript",
                "tsx",
                "css",
                "json",
                "markdown",
                "markdown_inline",
                "prisma"
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
