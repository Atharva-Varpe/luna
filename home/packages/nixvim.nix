{ pkgs, inputs, ... }:

{
  imports = [
    ./nixvim-keymaps.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = {
      web-devicons.enable = true;
      
      # File tree
      nvim-tree = {
        enable = true;
        settings = {
          view = {
            side = "left";
            width = 30;
          };
          renderer.icons.show = {
            file = true;
            folder = true;
            folder_arrow = true;
          };
          actions = {
            open_file = {
              quit_on_open = false;
              resize_window = true;
              window_picker = {
                enable = true;
              };
            };
          };
          sync_root_with_cwd = true;  # Sync tree root with current working directory
          respect_buf_cwd = true;     # Respect buffer's working directory
        };
        openOnSetup = true;
      };

      # UI components
      lualine.enable = true;
      bufferline.enable = true;
      nvim-surround.enable = true;

      # Which-key for command/keybind discovery
      which-key = {
        enable = true;
        settings = {
          delay = 500;
          expand = 1;
          notify = false;
        };
      };

      # Treesitter for syntax highlighting and parsing
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          cpp
          css
          dockerfile
          fish
          go
          html
          javascript
          json
          lua
          markdown
          nix
          python
          rust
          toml
          typescript
          vim
          yaml
        ];
      };

      # LSP configuration
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          basedpyright.enable = true;
          lua_ls.enable = true;
          ts_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          clangd.enable = true;
        };
        keymaps = {
          silent = true;
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "K" = "hover";
            "<C-k>" = "signature_help";
          };
        };
      };

      # Autocompletion with nvim-cmp
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      # Snippet engine
      luasnip.enable = true;

      # Auto-formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "black" "isort" ];
            nix = [ "alejandra" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            json = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };

      # Additional helpful plugins
      gitsigns.enable = true;
      indent-blankline = {
        enable = true;
        settings = {
          indent.char = "│";
          scope.enabled = false;
        };
      };
      comment.enable = true;
      nvim-autopairs.enable = true;
      
      # Fuzzy finder (fzf-lua)
      fzf-lua = {
        enable = true;
        settings = {
          winopts = {
            height = 0.85;
            width = 0.80;
            preview = {
              default = "bat";
              border = "border";
              wrap = "nowrap";
              hidden = "nohidden";
            };
          };
        };
      };
      
      # Dashboard
      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
            week_header.enable = false;
            shortcut = [
              {
                desc = "󰊳 Update";
                group = "@property";
                action = "Lazy update";
                key = "u";
              }
              {
                desc = " Files";
                group = "Label";
                action = "FzfLua files";
                key = "f";
              }
              {
                desc = " Recent";
                group = "Number";
                action = "FzfLua oldfiles";
                key = "r";
              }
            ];
          };
        };
      };
    };

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      mouse = "a";
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      scrolloff = 8;
      sidescrolloff = 8;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
