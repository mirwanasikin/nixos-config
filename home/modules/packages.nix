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
    firefox
    proton-vpn
    mpv
    imv
    obsidian

    # Communications
    zoom-us
    ferdium
    thunderbird
  ];
}
