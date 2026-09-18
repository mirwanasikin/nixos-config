_:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        separator = "->   ";
        color = {
          separator = "1";
        };
        constants = [
          "───────────────────────────"
        ];
        key = {
          type = "both";
          paddingLeft = 4;
        };
      };

      logo = {
        color = {
          "1" = "#bac2de";
          "2" = "#9399b2";
          "3" = "#bac2de";
          "4" = "#9399b2";
          "5" = "#bac2de";
          "6" = "#9399b2";
        };
      };

      modules = [
        "break"
        {
          type = "custom";
          format = "┌{$1} {#1}System Information{#} {$1}┐";
        }
        "break"
        {
          key = "Distro       ";
          keyColor = "#b4befe";
          type = "os";
        }
        {
          key = "Machine      ";
          keyColor = "#b4befe";
          type = "host";
        }
        {
          key = "Kernel       ";
          keyColor = "#b4befe";
          type = "kernel";
        }
        {
          key = "Packages     ";
          keyColor = "#b4befe";
          type = "packages";
        }
        {
          key = "Uptime       ";
          keyColor = "#b4befe";
          type = "uptime";
        }
        {
          key = "OS Age       ";
          keyColor = "#b4befe";
          type = "command";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          key = "Resolution   ";
          keyColor = "#b4befe";
          type = "display";
          compactType = "original-with-refresh-rate";
        }
        {
          key = "WM           ";
          keyColor = "#b4befe";
          type = "wm";
        }
        {
          key = "DE           ";
          keyColor = "#b4befe";
          type = "de";
        }
        {
          key = "Shell        ";
          keyColor = "#b4befe";
          type = "shell";
        }
        {
          key = "Terminal     ";
          keyColor = "#b4befe";
          type = "terminal";
        }
        {
          key = "CPU          ";
          keyColor = "#b4befe";
          type = "cpu";
        }
        {
          key = "Memory       ";
          keyColor = "#b4befe";
          type = "memory";
        }
        {
          key = "Disk         ";
          keyColor = "#b4befe";
          type = "disk";
        }
        {
          key = "Local IP     ";
          keyColor = "#b4befe";
          type = "localip";
          compact = true;
        }
        {
          key = "Media        ";
          keyColor = "#b4befe";
          type = "media";
        }
        "break"
        {
          type = "custom";
          format = "└{$1}────────────────────{$1}┘";
        }
        "break"
      ];
    };
  };
}
