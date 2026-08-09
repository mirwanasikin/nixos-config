{ pkgs, ... }:

{
  # Initrd
  boot.kernelParams = [
    "quiet"
    "splash"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.systemd.enable = true;

  # LUKS Encrypted swap
  # Used in the future
  # boot.initrd.secrets = {
  #   "/etc/secrets/swap.key" = /etc/secrets/swap.key;
  # };

  # boot.initrd.luks.devices."swap" = {
  #   device = "/dev/disk/by-uuid/XXXXXXXXXXXXXX";
  #   keyFile = "/etc/secrets/swap.key";
  # };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];

  boot.resumeDevice = "/dev/disk/by-label/swap";

  # GRUB
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    theme =
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "grub";
        rev = "main";
        hash = "sha256-jgM22pvCQvb0bjQQXoiqGMgScR9AgCK3OfDF5Ud+/mk=";
      }
      + "/src/catppuccin-macchiato-grub-theme";
  };

  # Plymouth
  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };

  # TEMPORARY PATCHES!
  boot.blacklistedKernelModules = [
    "esp4"
    "esp6"
    "rxrpc"
  ];

}
