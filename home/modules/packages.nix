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

    # System monitoring
    btop
    htop
    duf
    ncdu
    dust
    speedtest-cli
    ouch

    # Dev tools
    gh
    lazygit
    neovim
    jq
    awscli2
    ssm-session-manager-plugin
    ansible
    terraform
    kdePackages.kdeconnect-kde
    kubectl
    markdownlint-cli2
    marksman
    gnupg

    # Shell utilities
    tldr
    fastfetch
    figlet
    atuin
    bluetui
    cava
    playerctl

    # Media $ Apps
    google-chrome
    mpv
    imv

    # Communications
    zoom-us
    ferdium
    thunderbird
  ];
}
