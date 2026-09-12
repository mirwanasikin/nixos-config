{ ... }:

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
    ./modules/users.nix
    ./modules/settings.nix
    ./modules/agenix.nix
    ./modules/kernel.nix
    ./modules/9router.nix
  ];

}
