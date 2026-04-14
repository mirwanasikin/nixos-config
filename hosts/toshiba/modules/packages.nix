{ pkgs, inputs, ... }:

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
    dunst
    libnotify

    # Container Tools
    podman
    podman-compose
    buildah
    skopeo
    docker
    docker-compose

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

    # Cert
    mkcert
    nssTools
    inputs.agenix.packages."x86_64-linux".default

    # Theming
    catppuccin-sddm
  ];
}
