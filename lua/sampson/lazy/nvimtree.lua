return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = { enable = true },
            },
            view = {
                width = 30, -- sidebar width
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        modified = true, -- <- this is the key setting
                    },
                },
            },
            filters = {
                dotfiles = false, -- show dotfiles by default
            },
            git = {
                enable = true,
                ignore = false, -- 💥 this disables hiding gitignored files
            },
            modified = {
                enable = true, -- <- enable tracking modified files
                show_on_dirs = true, -- <- optional: show [+] on modified folders
                show_on_open_dirs = true, -- <- optional
            },
        })
    end
}
