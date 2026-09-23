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
    xwayland-satellite
    wayland-utils
    libnotify

    # Container Tools
    docker
    docker-compose
    kind

    # Hardware Tools
    pciutils
    usbutils
    binutils
    smartmontools
    brightnessctl
    gvfs
    ntfs3g

    # Debug Forensics
    file
    binwalk
    gdb
    strace
    lsof

    # Code
    gcc
    gnumake
    gdb
    python3
    clang
    rustc
    zig

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
