{ config, pkgs, ... }:

{
  programs.niri = {
    package = pkgs.niri;

    settings = {
      prefer-no-csd = true;

      input = {
        keyboard = {
          repeat-delay = 300;
          repeat-rate = 30;
          numlock = true;
        };

        touchpad.tap = true;

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      outputs."eDP-1" = {
        mode = {
          width = 1366;
          height = 768;
          refresh = 60.03;
        };
        scale = 2.0;
        position = {
          x = 1280;
          y = 0;
        };
      };

      layout = {
        gaps = 10;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          width = 4;
          active = {
            color = "#cba6f7";
          };
          inactive = {
            color = "#1e1e2e";
          };
          urgent = {
            color = "#f38ba8";
          };
        };

        border = {
          enable = false;
          width = 2;
          active = {
            color = "#cba6f7";
          };
          inactive = {
            color = "#6d10da";
          };
          urgent = {
            color = "#f38ba8";
          };
        };

        tab-indicator = {
          active = {
            color = "#cba6f7";
          };
          inactive = {
            color = "#6d10da";
          };
          urgent = {
            color = "#f38ba8";
          };
        };

        insert-hint = {
          display = {
            color = "#cba6f780";
          };
        };

        shadow = {
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };
      };

      spawn-at-startup = [
        { argv = [ "noctalia" ]; }
      ];

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      window-rules = [
        { open-maximized = true; }
      ];

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };

      recent-windows = {
        highlight = {
          active-color = "#cba6f7";
          urgent-color = "#f38ba8";
        };
      };

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash" = {
          action = show-hotkey-overlay;
        };

        "Mod+Return" = {
          action = spawn "foot";
          hotkey-overlay.title = "Open a Terminal: foot";
        };

        "Mod+D" = {
          action = spawn-sh "noctalia msg panel-toggle launcher";
          hotkey-overlay.title = "Run an Application: noctalia";
        };

        "Super+Alt+L" = {
          action = spawn-sh "noctalia msg session lock";
          hotkey-overlay.title = "Lock the Screen: Noctalia Lock ";
        };

        "Super+Alt+S" = {
          action = spawn-sh "pkill orca || exec orca";
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
        };

        "XF86AudioRaiseVolume" = {
          action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
          allow-when-locked = true;
        };

        "XF86AudioLowerVolume" = {
          action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          allow-when-locked = true;
        };

        "XF86AudioMute" = {
          action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };

        "XF86AudioMicMute" = {
          action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };

        "XF86AudioPlay" = {
          action = spawn-sh "playerctl play-pause";
          allow-when-locked = true;
        };

        "XF86AudioStop" = {
          action = spawn-sh "playerctl stop";
          allow-when-locked = true;
        };

        "XF86AudioPrev" = {
          action = spawn-sh "playerctl previous";
          allow-when-locked = true;
        };

        "XF86AudioNext" = {
          action = spawn-sh "playerctl next";
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp" = {
          action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
          allow-when-locked = true;
        };

        "XF86MonBrightnessDown" = {
          action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
          allow-when-locked = true;
        };

        "Mod+O" = {
          action = toggle-overview;
          repeat = false;
        };

        "Mod+Q" = {
          action = close-window;
          repeat = false;
        };

        "Mod+Left" = {
          action = focus-column-left;
        };
        "Mod+Down" = {
          action = focus-window-down;
        };
        "Mod+Up" = {
          action = focus-window-up;
        };
        "Mod+Right" = {
          action = focus-column-right;
        };
        "Mod+H" = {
          action = focus-column-left;
        };
        "Mod+L" = {
          action = focus-column-right;
        };

        "Mod+Ctrl+Left" = {
          action = move-column-left;
        };
        "Mod+Ctrl+Down" = {
          action = move-window-down;
        };
        "Mod+Ctrl+Up" = {
          action = move-window-up;
        };
        "Mod+Ctrl+Right" = {
          action = move-column-right;
        };
        "Mod+Ctrl+H" = {
          action = move-column-left;
        };
        "Mod+Ctrl+J" = {
          action = move-window-down;
        };
        "Mod+Ctrl+K" = {
          action = move-window-up;
        };
        "Mod+Ctrl+L" = {
          action = move-column-right;
        };

        "Mod+J" = {
          action = focus-window-or-workspace-down;
        };
        "Mod+K" = {
          action = focus-window-or-workspace-up;
        };

        "Mod+Home" = {
          action = focus-column-first;
        };
        "Mod+End" = {
          action = focus-column-last;
        };
        "Mod+Ctrl+Home" = {
          action = move-column-to-first;
        };
        "Mod+Ctrl+End" = {
          action = move-column-to-last;
        };

        "Mod+Shift+Left" = {
          action = focus-monitor-left;
        };
        "Mod+Shift+Down" = {
          action = focus-monitor-down;
        };
        "Mod+Shift+Up" = {
          action = focus-monitor-up;
        };
        "Mod+Shift+Right" = {
          action = focus-monitor-right;
        };
        "Mod+Shift+H" = {
          action = focus-monitor-left;
        };
        "Mod+Shift+J" = {
          action = focus-monitor-down;
        };
        "Mod+Shift+K" = {
          action = focus-monitor-up;
        };
        "Mod+Shift+L" = {
          action = focus-monitor-right;
        };

        "Mod+Shift+Ctrl+Left" = {
          action = move-column-to-monitor-left;
        };
        "Mod+Shift+Ctrl+Down" = {
          action = move-column-to-monitor-down;
        };
        "Mod+Shift+Ctrl+Up" = {
          action = move-column-to-monitor-up;
        };
        "Mod+Shift+Ctrl+Right" = {
          action = move-column-to-monitor-right;
        };
        "Mod+Shift+Ctrl+H" = {
          action = move-column-to-monitor-left;
        };
        "Mod+Shift+Ctrl+J" = {
          action = move-column-to-monitor-down;
        };
        "Mod+Shift+Ctrl+K" = {
          action = move-column-to-monitor-up;
        };
        "Mod+Shift+Ctrl+L" = {
          action = move-column-to-monitor-right;
        };

        "Mod+Page_Down" = {
          action = focus-workspace-down;
        };
        "Mod+Page_Up" = {
          action = focus-workspace-up;
        };
        "Mod+U" = {
          action = focus-workspace-down;
        };
        "Mod+I" = {
          action = focus-workspace-up;
        };

        "Mod+Ctrl+Page_Down" = {
          action = move-column-to-workspace-down;
        };
        "Mod+Ctrl+Page_Up" = {
          action = move-column-to-workspace-up;
        };
        "Mod+Ctrl+U" = {
          action = move-column-to-workspace-down;
        };
        "Mod+Ctrl+I" = {
          action = move-column-to-workspace-up;
        };

        "Mod+Shift+Page_Down" = {
          action = move-workspace-down;
        };
        "Mod+Shift+Page_Up" = {
          action = move-workspace-up;
        };
        "Mod+Shift+U" = {
          action = move-workspace-down;
        };
        "Mod+Shift+I" = {
          action = move-workspace-up;
        };

        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };

        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };

        "Mod+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };

        "Mod+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight" = {
          action = focus-column-right;
        };
        "Mod+WheelScrollLeft" = {
          action = focus-column-left;
        };
        "Mod+Ctrl+WheelScrollRight" = {
          action = move-column-right;
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          action = move-column-left;
        };
        "Mod+Shift+WheelScrollDown" = {
          action = focus-column-right;
        };
        "Mod+Shift+WheelScrollUp" = {
          action = focus-column-left;
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          action = move-column-right;
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          action = move-column-left;
        };

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        "Mod+Shift+1".action = {
          move-column-to-workspace = 1;
        };
        "Mod+Shift+2".action = {
          move-column-to-workspace = 2;
        };
        "Mod+Shift+3".action = {
          move-column-to-workspace = 3;
        };
        "Mod+Shift+4".action = {
          move-column-to-workspace = 4;
        };
        "Mod+Shift+5".action = {
          move-column-to-workspace = 5;
        };
        "Mod+Shift+6".action = {
          move-column-to-workspace = 6;
        };
        "Mod+Shift+7".action = {
          move-column-to-workspace = 7;
        };
        "Mod+Shift+8".action = {
          move-column-to-workspace = 8;
        };
        "Mod+Shift+9".action = {
          move-column-to-workspace = 9;
        };

        "Mod+BracketLeft" = {
          action = consume-or-expel-window-left;
        };
        "Mod+BracketRight" = {
          action = consume-or-expel-window-right;
        };
        "Mod+Comma" = {
          action = consume-window-into-column;
        };
        "Mod+Period" = {
          action = expel-window-from-column;
        };

        "Mod+R" = {
          action = switch-preset-column-width;
        };
        "Mod+Shift+R" = {
          action = switch-preset-column-width-back;
        };
        "Mod+Ctrl+Shift+R" = {
          action = switch-preset-window-height;
        };
        "Mod+Ctrl+R" = {
          action = reset-window-height;
        };

        "Mod+F" = {
          action = maximize-column;
        };
        "Mod+Shift+F" = {
          action = fullscreen-window;
        };
        "Mod+M" = {
          action = maximize-window-to-edges;
        };
        "Mod+Ctrl+F" = {
          action = expand-column-to-available-width;
        };

        "Mod+C" = {
          action = center-column;
        };
        "Mod+Ctrl+C" = {
          action = center-visible-columns;
        };

        "Mod+Minus" = {
          action = set-column-width "-10%";
        };
        "Mod+Equal" = {
          action = set-column-width "+10%";
        };
        "Mod+Shift+Minus" = {
          action = set-window-height "-10%";
        };
        "Mod+Shift+Equal" = {
          action = set-window-height "+10%";
        };

        "Mod+V" = {
          action = toggle-window-floating;
        };
        "Mod+Shift+V" = {
          action = switch-focus-between-floating-and-tiling;
        };
        "Mod+W" = {
          action = toggle-column-tabbed-display;
        };

        "Print".action = {
          screenshot = [ ];
        };
        "Ctrl+Print".action = {
          screenshot-screen = [ ];
        };
        "Alt+Print".action = {
          screenshot-window = [ ];
        };

        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };

        "Mod+Shift+E" = {
          action = spawn-sh "noctalia msg panel-toggle session";
        };

        "Ctrl+Alt+Delete" = {
          action = quit;
        };

        "Mod+Shift+P" = {
          action = power-off-monitors;
        };
      };
    };
  };
}
