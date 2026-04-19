{self, ...}: {
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

                   require("lz.n").load {
              {
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
                  end
              },
              {
                       "blink.cmp",
                       lazy = false,
                       after = function()
                         require("blink.cmp").setup()
                       end
                     },
              {
                       "lualine.nvim",
                       lazy = false,
                       after = function()
                         require("lualine").setup({
                             sections = {
                                 lualine_b = {},
                             }
                         })
                       end
              },
              {
                       "nvim-autopairs",
                       event = "DeferredUIEnter",
                       after = function()
                         require("nvim-autopairs").setup()
                       end
              },
          }
        '';
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            lz-n
            # oil-nvim
            nvim-lspconfig
            nvim-treesitter.withAllGrammars
            nvim-web-devicons
            lspkind-nvim
            blink-cmp
            # snacks-nvim
            lualine-nvim
            nvim-autopairs
          ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      lua-language-server
    ];
  };
}
