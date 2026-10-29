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
    speedtest-cli

    # Dev tools
    gh
    glab
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
    age
    sops

    # Shell utilities
    tldr
    bluetui

    # Media & Apps
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
    chatgpt
    opencode
    claude-code
    graphify
    wlctl
  ];

}
