{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    enableZshIntegration = true;

    # -------------------------------------------------------
    # Plugins
    # -------------------------------------------------------
    plugins = {
      ouch = pkgs.yaziPlugins.ouch;
      sudo = pkgs.yaziPlugins.sudo;
      rsync = pkgs.yaziPlugins.rsync;
      diff = pkgs.yaziPlugins.diff;
      yatline = pkgs.yaziPlugins.yatline;
      yatline-catppuccin = pkgs.yaziPlugins.yatline-catppuccin;
    };

    # -------------------------------------------------------
    # Flavors — Catppuccin Mocha dari yazi-rs/flavors
    # -------------------------------------------------------
    flavors =
      let
        repo = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "fc8eeaab9da882d0e77ecb4e603b67903a94ee6e";
          hash = "sha256-wvxwK4QQ3gUOuIXpZvrzmllJLDNK6zqG5V2JAqTxjiY=";
        };
      in
      {
        catppuccin-mocha = repo + "/catppuccin-mocha.yazi";
      };

    # -------------------------------------------------------
    # theme.toml — aktifkan flavor
    # -------------------------------------------------------
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
        light = "catppuccin-mocha";
      };
    };

    # -------------------------------------------------------
    # init.lua — plugin initialization
    # -------------------------------------------------------
    initLua = ''
      -- Yatline dengan tema Catppuccin Mocha
      require("yatline-catppuccin"):setup("mocha")
      require("yatline"):setup({
        section_separator = { open = "", close = "" },
        part_separator    = { open = "", close = "" },

        style_a = {
          fg = "black",
          bg_mode = {
            normal  = "#89b4fa", -- blue
            select  = "#a6e3a1", -- green
            un_set  = "#f38ba8", -- red
          },
        },
        style_b = { bg = "#313244" },
        style_c = { bg = "#1e1e2e" },

        permissions_t_fg = "green",
        permissions_r_fg = "yellow",
        permissions_w_fg = "red",
        permissions_x_fg = "cyan",
        permissions_s_fg = "white",

        tab_width          = 20,
        tab_use_inverse    = false,

        selected           = { icon = "󰻭", fg = "yellow" },
        copied             = { icon = "", fg = "green" },
        cut                = { icon = "", fg = "red" },

        total              = { icon = "󰮍", fg = "yellow" },
        succ               = { icon = "", fg = "green" },
        fail               = { icon = "", fg = "red" },
        found              = { icon = "󰮕", fg = "blue" },
        processed          = { icon = "󰐍", fg = "green" },

        show_background    = true,

        display_header_line = true,
        display_status_line = true,

        header_line = {
          left = {
            section_a = {
              { type = "line", custom = false, name = "tabs", params = { "left" } },
            },
          },
          right = {
            section_a = {
              { type = "string", custom = false, name = "date", params = { "%H:%M" } },
            },
            section_b = {
              { type = "string", custom = false, name = "date", params = { "%d/%m/%Y" } },
            },
            section_c = {},
          },
        },

        status_line = {
          left = {
            section_a = {
              { type = "string", custom = false, name = "tab_mode" },
            },
            section_b = {
              { type = "string", custom = false, name = "hovered_size" },
            },
            section_c = {
              { type = "string", custom = false, name = "hovered_path" },
              { type = "coloreds", custom = false, name = "count" },
            },
          },
          right = {
            section_a = {
              { type = "string", custom = false, name = "cursor_position" },
            },
            section_b = {
              { type = "string", custom = false, name = "cursor_percentage" },
            },
            section_c = {
              { type = "string", custom = false, name = "hovered_file_extension", params = { true } },
              { type = "coloreds", custom = false, name = "permissions" },
            },
          },
        },
      })
    '';

    # -------------------------------------------------------
    # keymap.toml — tambahan keymap untuk plugin
    # -------------------------------------------------------
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "<C-a>" ];
          run = "plugin ouch --args=compress";
          desc = "Compress dengan ouch";
        }
        {
          on = [ "<C-x>" ];
          run = "plugin ouch --args=extract";
          desc = "Extract dengan ouch";
        }
        {
          on = [ "<C-s>" ];
          run = "plugin sudo";
          desc = "Operasi file dengan sudo";
        }
        {
          on = [ "<C-d>" ];
          run = "plugin diff";
          desc = "Diff dua file";
        }
        {
          on = [ "P" ];
          run = "plugin rsync";
          desc = "Paste dengan rsync";
        }
      ];
    };
  };
}
