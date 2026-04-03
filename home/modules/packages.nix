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

    # Shell utilities
    tldr
    fastfetch
    figlet
    atuin
    bluetui
    cava
    playerctl

    # Zoom
    zoom-us
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
