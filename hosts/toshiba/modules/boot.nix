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
  boot.initrd.secrets = {
    "/etc/secrets/swap.key" = /etc/secrets/swap.key;
  };

  boot.initrd.luks.devices."swap" = {
    device = "/dev/disk/by-uuid/eca7241b-b49e-4fdf-87bd-b5aa75ed75c4"; # UUID sda2 baru
    keyFile = "/etc/secrets/swap.key";
  };

  swapDevices = [
    {
      device = "/dev/mapper/swap";
    }
  ];

  boot.resumeDevice = "/dev/mapper/swap";

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

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;

}
