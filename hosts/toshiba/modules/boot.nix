{ pkgs, ... }:

{
  # Initrd
  boot = {
    kernelParams = [
      "quiet"
      "splash"
    ];

    consoleLogLevel = 0;

    initrd = {
      verbose = false;
      kernelModules = [ "i915" ];
      systemd.enable = true;
    };

    resumeDevice = "/dev/disk/by-label/swap";

    # GRUB
    loader = {
      grub = {
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
    };

    # plymouth
    plymouth = {
      enable = true;
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-macchiato";
    };

    blacklistedKernelModules = [
      "esp4"
      "esp6"
      "rxrpc"
    ];
  };

  # LUKS Encrypted swap
  # Used in the future
  # boot.initrd.secrets = {
  #   "/etc/secrets/swap.key" = /etc/secrets/swap.key;
  # };

  # boot.initrd.luks.devices."swap" = {
  #   device = "/dev/disk/by-uuid/XXXXXXXXXXXXXX";
  #   keyFile = "/etc/secrets/swap.key";
  # };
}
