{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors
    vim

    # Network tools
    wget
    curl
    git
    dig
    iperf
    nmap
    tcpdump

    # Sway Ecosystem
    swaylock
    swaybg
    swayidle
    waybar
    rofi
    wlogout
    wayland-utils

    # Container Tools
    podman
    podman-compose
    buildah
    skopeo

    # Hardware Tools
    pciutils
    usbutils
    binutils

    # Debug Forensics
    gcc
    file
    binwalk
    gdb
    strace
    lsof

    # Theming
    catppuccin-sddm
  ];
}
