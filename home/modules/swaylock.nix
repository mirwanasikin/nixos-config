{ config, ... }:

let
  homeDir = config.home.homeDirectory;
in

{
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${homeDir}/.config/sway/assets/wallpaper/dark-forest.jpg";
      scaling = "fill";
    };
  };

  catppuccin.swaylock = {
    enable = true;
    flavor = "mocha";
  };
}
