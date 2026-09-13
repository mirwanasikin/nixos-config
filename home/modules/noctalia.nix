_:

{

  programs.noctalia = {
    enable = true;

    settings = {
      bar.default = {
        border = "primary";
        center = [ "workspaces" ];
        end = [
          "cpu"
          "ram"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "battery"
        ];
        font_weight = 700;
        layer = "top";
        margin_edge = 5;
        margin_ends = 80;
        panel_overlap = 0;
        radius = 14;
        shadow = false;
        start = [
          "date"
          "clock"
          "media"
          "active_window"
        ];
        thickness = 30;
      };

      dock = {
        icon_size = 35;
        main_axis_padding = 6;
        shadow = false;
      };

      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];

        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900;
          };
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
      };

      location = {
        address = "Palangka Raya, Indonesia";
      };

      lockscreen = {
        blur_intensity = 0.0;
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@LVDS-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "lockscreen-login-box@LVDS-1" = {
            box_height = 196.0;
            box_width = 720.0;
            cx = 683.0;
            cy = 649.0;
            output = "LVDS-1";
            placement_height = 768.0;
            placement_width = 1366.0;
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };

          "lockscreen-widget-0000000000000001" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 683.0;
            cy = 95.5;
            output = "LVDS-1";
            placement_height = 768.0;
            placement_width = 1366.0;
            rotation = 0.0;
            type = "clock";
          };

          "lockscreen-widget-0000000000000002" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 670.0;
            cy = 432.0;
            output = "LVDS-1";
            placement_height = 768.0;
            placement_width = 1366.0;
            rotation = 0.0;
            type = "media_player";
          };
        };
      };

      shell = {
        app_icon_color = "on_primary";
        corner_radius_scale = 0.95000001415610313;
        font_family = "JetBrainsMono NF";
        settings_show_advanced = true;
        telemetry_enabled = false;

        panel = {
          borders = false;
          control_center_placement = "floating";
          launcher_placement = "floating";
          session_placement = "floating";
          shadow = false;
        };

        session.actions = [
          {
            action = "lock";
            enabled = true;
            shortcut = "1";
            variant = "default";
          }
          {
            action = "logout";
            enabled = true;
            shortcut = "2";
            variant = "default";
          }
          {
            action = "lock_and_suspend";
            enabled = true;
            glyph = "suspend";
            label = "Suspend";
            shortcut = "3";
            variant = "default";
          }
          {
            action = "reboot";
            enabled = true;
            shortcut = "4";
            variant = "default";
          }
          {
            action = "command";
            command = "noctalia msg session lock && systemctl hibernate";
            enabled = true;
            glyph = "zzz";
            label = "Hibernate";
            shortcut = "5";
            variant = "default";
          }
          {
            action = "shutdown";
            enabled = true;
            shortcut = "6";
            variant = "destructive";
          }
        ];

        shadow = {
          alpha = 0.0;
        };
      };

      theme = {
        builtin = "Catppuccin";
        community_palette = "Catppuccin Lavender";
        custom_palette = "Ayu";
        mode = "dark";
        source = "builtin";
        wallpaper_scheme = "ADW";

        templates = {
          builtin_ids = [
            "cava"
          ];
        };
      };

      wallpaper = {
        directory = "/home/irwan/Pictures/Wallpaper";
        edge_smoothness = 0.0;
        transition_on_startup = true;

        automation = {
          interval_seconds = 1800;
          order = "random";
          recursive = true;
        };

        default.path = "/home/irwan/Pictures/Wallpaper/suisei3.jpg";
        last.path = "/home/irwan/Pictures/Wallpaper/suisei3.jpg";

        monitors."LVDS-1".path = "/home/irwan/Pictures/Wallpaper/suisei3.jpg";
      };

      widget = {
        network.show_label = false;
        sysmon.stat = "disk_pct";
        volume.show_label = false;
      };
    };
  };
}
