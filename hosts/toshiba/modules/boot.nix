{ pkgs, ... }:

{
  # Initrd
  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=3"
    ];

    consoleLogLevel = 3;

    resumeDevice = "/dev/disk/by-label/swap";

    initrd = {
      kernelModules = [ "i915" ];
    };

    # GRUB
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };

    plymouth.enable = true;

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
