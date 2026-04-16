{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI essentials
    eza
    fd
    fzf
    ripgrep
    yazi
    bat
    glow
    hyperfine
    delta
    watchexec

    # System monitoring
    btop
    htop
    duf
    ncdu
    dust
    speedtest-cli
    ouch
    nix-output-monitor
    nvd
    nh

    # Dev tools
    gh
    lazygit
    neovim
    k9s
    terragrunt
    helm
    jq
    mods
    awscli2
    ssm-session-manager-plugin
    ansible
    terraform
    kdePackages.kdeconnect-kde
    kubectl

    # Shell utilities
    tldr
    fastfetch
    figlet
    atuin
    bluetui

    # Media $ Apps
    proton-vpn
    brave
    mpv
    imv
    obsidian
    cava
    playerctl

    # Communications
    zoom-us
    ferdium
    thunderbird
  ];
}
