{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Editors
    vim

    # Network tools
    wget
    curl
    dig
    iperf
    nmap
    tcpdump

    # Niri
    niri
    # noctalia-shell
    (inputs.noctalia-v5.packages.${pkgs.system}.default)
    xwayland-satellite
    wayland-utils
    libnotify

    # Container Tools
    podman
    podman-compose
    docker
    docker-compose

    # Hardware Tools
    pciutils
    usbutils
    binutils
    smartmontools
    brightnessctl
    gvfs
    simple-mtpfs

    # Debug Forensics
    gcc
    file
    binwalk
    gdb
    strace
    lsof

    # Code
    python3
    clang

    # Cert
    mkcert
    nssTools
    inputs.agenix.packages."x86_64-linux".default

    # Theming
    catppuccin-sddm
    bibata-cursors

    # Screenshot
    grim
    slurp
  ];
}
