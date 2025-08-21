return {
    -- Mason: manages external tools (LSP servers, formatters)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- Mason Tool Installer: only Prettier
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "prettier",
                    "eslint",
                },
                auto_update = true,
                run_on_start = true,
            })
        end
    },

    -- LSP with Mason (patched for Next.js + TypeScript)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(client, bufnr)
                -- Disable tsserver formatting so only Prettier (null-ls) formats
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>F", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set("n", "<leader>e", function()
                    vim.diagnostic.open_float(nil, {
                        border = "rounded",
                        focusable = true,
                        scope = "cursor",
                    })
                end, opts)
            end

            -- List of language servers (including ts_ls explicitly)
            local servers = {
                "html",
                "cssls",
                "jsonls",
                "tailwindcss",
                "lua_ls",
                "emmet_language_server",
                "eslint"
            }

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            -- Configure each server
            for _, server in ipairs(servers) do
                local opts = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }

                if server == "emmet_language_server" then
                    opts.filetypes = {
                        "html", "css", "typescriptreact", "javascriptreact",
                        "sass", "scss", "less", "svelte",
                    }
                end

                if server == "ts_ls" then
                    -- Explicitly disable formatting inside tsserver too
                    opts.settings = {
                        javascript = { format = { enable = false } },
                        typescript = { format = { enable = false } },
                    }
                end

                if server == "eslint" then
                    opts.settings = {
                        experimental = {
                            useFlatConfig = false, -- 👈 tell eslint-lsp to use .eslintrc
                        },
                    }
                end

                lspconfig[server].setup(opts)
            end
        end
    },

    -- Autocompletion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.filetype_extend("typescriptreact", { "javascriptreact", "typescript" })

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end
    },
    -- Prettier formatting (null-ls only)
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.code_actions.eslint,
                    null_ls.builtins.formatting.eslint,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method and client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end
    },

}
