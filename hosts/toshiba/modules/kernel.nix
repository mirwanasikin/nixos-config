{
  pkgs,
  config,
  inputs,
  ...
}:

{
  # NixOS Kernel
  boot.kernelPackages = pkgs.linuxPackages;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel Compile
  # boot.kernelPackages = pkgs.linuxPackagesFor (
  #   pkgs.buildLinux {
  #     version = "7.0";
  #     modDirVersion = "7.0.0";

  #    src = pkgs.fetchurl {
  #      url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-7.0.tar.gz";
  #      hash = "sha256-EOr/mr2n/jZwcTk+0n5Wwbvjb8j7cZpA5+B7e/ZTj+0=";
  #    };
  #
  #    configfile = config.boot.kernelPackages.kernel.configfile;
  #    allowImportFromDerivation = true;
  #    ignoreConfigErrors = true;
  #    kernelPatches = [ ];
  #  }
  # );

  # Kernel Cachy
  # nixpkgs.overlays = [
  #   inputs.nix-cachyos-kernel.overlays.pinned
  # ];

  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-x86_64-v2;

  # Binary cache
  # nix.settings.substituters = [
  #   "https://cache.nixos.org"
  #   "https://attic.xuyh0120.win/lantian"
  #   "https://cache.garnix.io"
  # ];
  # nix.settings.trusted-public-keys = [
  #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #   "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
  #   "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  # ];

  # systemd.services.nix-daemon.serviceConfig.TimeoutStartSec = "infinity";
}
