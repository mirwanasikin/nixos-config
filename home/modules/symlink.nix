{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    niri = "niri";
    fastfetch = "fastfetch";
    yazi = "yazi";
  };

in

{
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
