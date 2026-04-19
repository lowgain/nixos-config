return {
    "nvim-lspconfig",
    lazy = false,

    before = function()

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Lua LSP
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    telemetry = {

                        enable = false
                    },
                    workspace = {
                        checkThirdParty = "Apply"
                    }
                },
            },
        })

        vim.lsp.config("lua_ls", { on_attach = on_attach, capabilities = capabilities })
        vim.lsp.enable("lua_ls")

        vim.lsp.config("nixd", {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "nixd" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "alejandra" },
                    },
                },
            },
        })
        vim.lsp.enable("nixd")

        vim.lsp.config("gleam", { on_attach = on_attach, capabilities = capabilities })
        vim.lsp.enable("gleam")
    end,
}
