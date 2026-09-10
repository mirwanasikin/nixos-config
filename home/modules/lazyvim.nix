{ pkgs, ... }:

{
  programs.lazyvim = {
    enable = true;

    extras = {
      ai.copilot-chat.enable = true;

      lang = {
        nix = {
          enable = true;
          installDependencies = true;
        };
        python = {
          enable = true;
          installDependencies = true;
        };
        rust = {
          enable = true;
          installDependencies = true;
        };
        yaml = {
          enable = true;
          installDependencies = true;
        };
        docker = {
          enable = true;
          installDependencies = true;
        };
        clangd = {
          enable = true;
          installDependencies = true;
        };
        terraform = {
          enable = true;
          installDependencies = true;
        };
        # marksman/markdownlint/pandoc sudah ada di formatter.nix
        markdown = {
          enable = true;
        };
      };

      ui.dashboard-nvim.enable = true;
      util.chezmoi.enable = true;
    };

    # LSP servers/tools yang tidak punya LazyVim extra
    extraPackages = with pkgs; [
      tofu-ls # untuk tofuls
      clang-tools # untuk clang-tidy
    ];

    config = {
      options = ''
        -- Transparent background
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })

        vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        vim.opt.termguicolors = true
      '';

      autocmds = ''
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = function()
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
            vim.api.nvim_set_hl(0, "SnacksExplorerNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "SnacksExplorerNormalNC", { bg = "none" })
          end,
        })
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksExplorerNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksExplorerNormalNC", { bg = "none" })
      '';
    };

    plugins = {
      theme = ''
        return {
          {
            "catppuccin/nvim",
            lazy = false,
            name = "catppuccin",
            priority = 1000,
            opts = {
              flavour = "mocha",
              transparent_background = true,
              term_colors = true,
              integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                  enabled = true,
                  underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                  },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
              },
            },
          },

          {
            "LazyVim/LazyVim",
            opts = {
              colorscheme = "catppuccin-mocha",
            },
          },

          {
            "nvimdev/dashboard-nvim",
            dependencies = { "catppuccin" },
          },
        }
      '';

      conform = ''
        return {
          "stevearc/conform.nvim",
          opts = {
            formatters_by_ft = {
              nix = { "nixfmt" },
              terraform = { "terraform_fmt" },
              yaml = { "prettier" },
              dockerfile = {},
              python = { "ruff_format" },
              c = { "clang_format" },
              rust = { "rustfmt" },
            },
          },
        }
      '';

      treesitter = ''
        return {
          "nvim-treesitter/nvim-treesitter",
          opts = {
            prefer_git = true,
          },
        }
      '';

      dashboard = ''
        return {
          "nvimdev/dashboard-nvim",
          lazy = false,
          opts = function()
            local logo = [[
         ██████╗██╗   ██╗ ██████╗██╗   ██╗
        ██╔════╝██║   ██║██╔════╝██║   ██║
        ██║     ██║   ██║██║     ██║   ██║
        ██║     ██║   ██║██║     ██║   ██║
        ╚██████╗╚██████╔╝╚██████╗╚██████╔╝
         ╚═════╝ ╚═════╝  ╚═════╝ ╚═════╝ 
            ]]

            logo = string.rep("\n", 8) .. logo .. "\n\n"

            local opts = {
              theme = "doom",
              hide = {
                statusline = false,
              },
              config = {
                header = vim.split(logo, "\n"),
                center = {
                  { action = 'lua LazyVim.pick()()',                desc = " Find File",       icon = " ", key = "f" },
                  { action = "ene | startinsert",                   desc = " New File",        icon = " ", key = "n" },
                  { action = 'lua LazyVim.pick("oldfiles")()',      desc = " Recent Files",    icon = " ", key = "r" },
                  { action = 'lua LazyVim.pick("live_grep")()',     desc = " Find Text",       icon = " ", key = "g" },
                  { action = 'lua LazyVim.pick.config_files()()',   desc = " Config",          icon = " ", key = "c" },
                  { action = 'lua require("persistence").load()',   desc = " Restore Session", icon = " ", key = "s" },
                  { action = "LazyExtras",                          desc = " Lazy Extras",     icon = " ", key = "x" },
                  { action = "Lazy",                                desc = " Lazy",            icon = "󰒲 ", key = "l" },
                  { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
                },
                footer = function()
                  local stats = require("lazy").stats()
                  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                  return { " Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                end,
              },
            }

            for _, button in ipairs(opts.config.center) do
              button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
              button.key_format = "  %s"
            end

            if vim.o.filetype == "lazy" then
              vim.api.nvim_create_autocmd("WinClosed", {
                pattern = tostring(vim.api.nvim_get_current_win()),
                once = true,
                callback = function()
                  vim.schedule(function()
                    vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
                  end)
                end,
              })
            end

            return opts
          end,
        }
      '';

      disable-marksman = ''
        return {
          "neovim/nvim-lspconfig",
          opts = {
            servers = {
              marksman = {
                enabled = false,
              },
            },
          },
        }
      '';

    };
  };
}
