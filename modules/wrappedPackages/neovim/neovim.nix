{
    flake.nixosModules.neovim = {pkgs, ...}: {
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            viAlias = true;
            configure = {
                customLuaRC = ''
                    local a = vim.api
                    local g = vim.g
                    local o = vim.opt

                    a.nvim_set_hl(0, 'Normal', { bg = 'none' })
                    a.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
                    a.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
                    a.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })


                    o.smartcase = true
                    o.ignorecase = true
                    o.relativenumber = true
                    o.wrap = false
                    o.tabstop = 4
                    o.shiftwidth = 4
                    o.expandtab = true

                    g.mapleader = " "

                    require("lz.n").load({
                        "blink.cmp",
                        lazy = false,
                        after = function()
                            require("blink.cmp").setup({
                            keymap = { preset = "super-tab" },
                            cmdline = {
                                keymap = { preset = 'inherit' },
                                completion = { menu = { auto_show = true } },
                            },
                            appearance = {
                                nerd_font_variant = "mono",
                            },
                            completion = {
                                trigger = {},
                                documentation = {
                                auto_show = true,
                                window = { border = 'single' },
                                },
                            },
                            sources = {
                                default = { "lsp", "path", "buffer" },
                            },
                            fuzzy = {
                                implementation = "prefer_rust_with_warning",
                            },
                            })
                        end
                    })
                    require("lz.n").load({
                        "nvim-lspconfig",
                        lazy = false,
                        before = function()
                            vim.lsp.config("*", {
                                capabilities = require("blink.cmp").get_lsp_capabilities(),
                            })
                            vim.lsp.enable("lua_ls")
                            vim.lsp.config("nixd", {
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
                            vim.lsp.enable("pyright")
                        end
                    })
                    require("lz.n").load({
                        "nvim-autopairs",
                        event = "DeferredUIEnter",
                        after = function()
                            require("nvim-autopairs").setup({
                                enable_moveright = true,
                                map_cr = true,
                            })
                        end
                    })
                    require("lz.n").load({
                        "lualine.nvim",
                        lazy = false,
                        after = function()
                            require("lualine").setup({})
                        end
                    })
                    require("lz.n").load({
                        "conform.nvim",
                        after = function()
                            require("conform").setup({
                                formatters_by_ft = {
                                    python = { "black" },
                                    nix = { "alejandra" }
                                },
                            })

                            a.nvim_create_autocmd("BufWritePre", {
                                pattern = "*",
                                callback = function(args)
                                    require("conform").format({ bufnr = args.buf })
                                end
                            })
                        end
                    })
                    require("lz.n").load({
                        "nvim-treesitter",
                        lazy = false,
                        after = function()
                            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    })
                '';
                packages.myVimPackage = {
                    start = with pkgs.vimPlugins; [
                        lz-n
                    ];
                    opt = with pkgs.vimPlugins; [
                        nvim-lspconfig
                        nvim-treesitter.withAllGrammars
                        lualine-nvim
                        nvim-autopairs
                        blink-cmp
                        conform-nvim
                    ];
                };
            };
        };

        environment.systemPackages = with pkgs; [
            lua-language-server
            nixd
            alejandra
            black
            pyright

        ];
    };
}
