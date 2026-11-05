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
    iw

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
    glib
    ntfs3g

    # Debug Forensics
    file
    binwalk
    strace
    lsof

    # Code
    gcc
    gnumake
    cmake
    libtool
    libvterm-neovim
    gdb
    python315
    clang
    rustc
    zig
    emacs-pgtk
    ((pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ]))
    # Cert
    mkcert
    nssTools
    inputs.agenix.packages."x86_64-linux".default

    # Theming
    bibata-cursors

    # Screenshot
    grim
    slurp
  ];
}
