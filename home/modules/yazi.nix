{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  flavor = config.catppuccin.flavor or "mocha";
  accent = config.catppuccin.accent or "mauve";

  upstreamYazi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "d62802be39210ea10e54b3e3b09735c6cb9e57c1";
    sha256 = "0qj40bshs8c1j3p1g6knd6c9lihy4dv8xgnsswd1r85iqwxw833g";
  };

  themeFile = "${upstreamYazi}/themes/${flavor}/catppuccin-${flavor}-${accent}.toml";
  rawTheme = builtins.readFile themeFile;

  transparentTheme =
    builtins.replaceStrings [ "overall = { bg = \"#1e1e2e\" }" ] [ "overall = { bg = \"reset\" }" ]
      rawTheme;

  batSource = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.bat;
in
{
  xdg.configFile = {
    "yazi/theme.toml".text = transparentTheme;
    "yazi/Catppuccin-${flavor}.tmTheme".source =
      "${batSource}/Catppuccin ${lib.toSentenceCase flavor}.tmTheme";
  };

  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "y";
      plugins = {
        ouch = pkgs.yaziPlugins.ouch;
        sudo = pkgs.yaziPlugins.sudo;
        gvfs = {
          package = pkgs.yaziPlugins.gvfs;
          setup = true;
        };
        chmod = pkgs.yaziPlugins.chmod;
        rsync = pkgs.yaziPlugins.rsync;
        lazygit = pkgs.yaziPlugins.lazygit;
        drag = pkgs.yaziPlugins.drag;
      };
      settings = {
        opener = {
          play = [
            {
              run = "mpv %s";
              orphan = true;
              "for" = "unix";
            }
          ];
          extract = [
            {
              run = "ouch d -y %s";
              desc = "Extract with ouch";
              "for" = "unix";
            }
          ];
        };
        open = {
          prepend_rules = [
            # From mimeapps.nix (video/mkv & video/avi are not registered
            # MIME types; use the real x- variants instead)
            {
              mime = "video/mp4";
              use = "play";
            }
            {
              mime = "video/x-matroska";
              use = "play";
            }
            {
              mime = "application/x-matroska";
              use = "play";
            }
            {
              mime = "video/webm";
              use = "play";
            }
            {
              mime = "video/x-msvideo";
              use = "play";
            }
            {
              mime = "video/quicktime";
              use = "play";
            }
            {
              mime = "video/mpeg";
              use = "play";
            }
            {
              mime = "video/ogg";
              use = "play";
            }
            {
              mime = "video/x-flv";
              use = "play";
            }
            {
              mime = "video/3gpp";
              use = "play";
            }
            {
              mime = "video/mp2t";
              use = "play";
            }
            # Ouch preview & extract
            {
              mime = "application/x-zip-compressed";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/zip";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/x-tar";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/x-bzip2";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/x-7z-compressed";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/x-rar";
              use = [
                "ouch"
                "extract"
              ];
            }
            {
              mime = "application/x-xz";
              use = [
                "ouch"
                "extract"
              ];
            }
            # Catch-all
            {
              mime = "video/*";
              use = "play";
            }
          ];
        };
        plugin = {
          prepend_previewers = [
            {
              mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
              run = "ouch";
            }
          ];
        };
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            on = [ "C" ];
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
          {
            on = [ "E" ];
            run = "open --opener=extract";
            desc = "Extract with ouch";
          }
          {
            on = [
              "c"
              "m"
            ];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
          {
            on = [ "R" ];
            run = "plugin rsync";
            desc = "Copy files using rsync";
          }
          # Sudo
          {
            on = [
              "v"
              "p"
            ];
            run = "plugin sudo -- paste";
            desc = "sudo paste";
          }
          {
            on = [
              "v"
              "r"
            ];
            run = "plugin sudo -- rename";
            desc = "sudo rename";
          }
          {
            on = [
              "v"
              "d"
            ];
            run = "plugin sudo -- remove";
            desc = "sudo trash";
          }
          # GVFS
          {
            on = [
              "M"
              "m"
            ];
            run = "plugin gvfs -- select-then-mount --jump";
            desc = "Mount device and jump";
          }
          {
            on = [
              "M"
              "u"
            ];
            run = "plugin gvfs -- select-then-unmount";
            desc = "Unmount device";
          }
          {
            on = [
              "g"
              "m"
            ];
            run = "plugin gvfs -- jump-to-device";
            desc = "Jump to device";
          }
          # Lazygit
          {
            on = [
              "g"
              "i"
            ];
            run = "plugin lazygit";
            desc = "Run lazygit";
          }
          {
            on = [ "<C-n>" ];
            run = "plugin drag";
            desc = "Drag selected files";
          }
        ];
      };
    };
  };
}
