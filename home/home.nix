{ inputs, config, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/foot.nix
    ./modules/firefox.nix
    ./modules/spicetify.nix
    ./modules/packages.nix
    ./modules/dotfiles.nix
    ./modules/gtk.nix
    ./modules/tmux.nix
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/mimeapps.nix
    ./modules/formatter.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/services.nix
    ./modules/wf-recorder.nix
    ./modules/symlink.nix
    ./modules/lazyvim.nix
    ./modules/noctalia.nix
  ];

  home = {
    username = "irwan";
    homeDirectory = "/home/irwan";
    stateVersion = "26.11";

    file."Pictures/Wallpaper" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/wallpaper";
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
