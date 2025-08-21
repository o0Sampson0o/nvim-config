return {
  "rafamadriz/friendly-snippets",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
        local luasnip = require("luasnip")

        -- Load all snippets from friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Make HTML also get JavaScript snippets ( for <script> tags )
        luasnip.filetype_extend("html", { "javascript" })

        -- Entend snippets for Next.js files
        luasnip.filetype_extend("typescriptreact", { "javascriptreact", "typescript" })
  end
}
