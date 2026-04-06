{ inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/foot.nix
    ./modules/spicetify.nix
    ./modules/packages.nix
    ./modules/dotfiles.nix
    ./modules/gtk.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
    ./modules/mimeapps.nix
    ./modules/formatter.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/services.nix
    ./modules/bat.nix
    ./modules/btop.nix
    ./modules/swaylock.nix
    ./modules/yazi.nix
    ./modules/dunst.nix
  ];

  home.username = "irwan";
  home.homeDirectory = "/home/irwan";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
