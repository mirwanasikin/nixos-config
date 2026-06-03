{
  pkgs,
  inputs,
  ...
}:

{
  # NixOS Kernel
  # boot.kernelPackages = pkgs.linuxPackages; # Kernel LTS
  # boot.kernelPackages = pkgs.linuxPackages_latest; # Kernel Latest

  # Kernel Cachy
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts;
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-lto;
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;

  # Binary cache
  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://attic.xuyh0120.win/lantian"
    "https://cache.garnix.io"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];

  systemd.services.nix-daemon.serviceConfig.TimeoutStartSec = "infinity";
}
