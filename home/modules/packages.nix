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
    delta
    watchexec
    ouch
    unrar
    unzip
    zip

    # System monitoring
    htop
    duf
    ncdu
    dust
    speedtest-cli
    nix-output-monitor
    nvd
    nh

    # Dev tools
    gh
    neovim
    k9s
    terragrunt
    kubernetes-helm
    jq
    mods
    awscli2
    ssm-session-manager-plugin
    ansible
    terraform
    opentofu
    kdePackages.kdeconnect-kde
    kubectl
    gitlab-ci-local

    # Shell utilities
    tldr
    nitch
    figlet
    bluetui
    nitch

    # Media & Apps
    proton-vpn
    mpv
    imv
    obsidian
    cava
    playerctl
    zathura
    gowall

    # Communications
    thunderbird

  ];

}
