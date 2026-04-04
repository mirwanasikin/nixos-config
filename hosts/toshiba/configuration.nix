{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/network.nix
    ./modules/packages.nix
    ./modules/virtualisation.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/services.nix
  ];

  # Users
  users.users.irwan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "kvm"
      "libvirtd"
      "video"
    ];
    shell = pkgs.zsh;
  };

  # Nix Settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # System Version
  system.stateVersion = "25.11";
}
