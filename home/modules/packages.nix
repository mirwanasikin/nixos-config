{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI essentials
    fd
    ripgrep
    lazydocker
    glow
    hyperfine
    ouch
    unrar
    watchexec
    ripdrag

    # System monitoring
    htop
    duf
    ncdu
    nix-output-monitor
    nvd
    nh
    hydra-check

    # Dev tools
    gh
    terragrunt
    kubernetes-helm
    jq
    mods
    awscli2
    ssm-session-manager-plugin
    ansible
    opentofu
    devenv
    kubectl
    kubeseal
    android-tools

    # Shell utilities
    tldr
    figlet
    bluetui

    # Media & Apps
    proton-vpn
    imv
    obsidian
    playerctl
    gowall
    spotatui
    yt-dlp
    chafa
    gophertube
    zathura

    # Browser
    w3m

    # Vibe Coding
    opencode
    graphify
  ];

}
