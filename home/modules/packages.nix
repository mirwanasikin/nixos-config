{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI essentials
    eza
    fd
    fzf
    ripgrep
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
    k9s
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
    mpv
    imv
    obsidian
    cava
    playerctl
    zathura
    gowall
    spotatui
    yt-dlp
    chafa
    gophertube

    # Browser
    w3m
    aerc

    # Vibe Coding
    opencode
    graphify
  ];

}
