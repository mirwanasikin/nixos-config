{ pkgs, ... }:

{
  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.defaultSession = "niri";

  # SDDm
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-mauve";
    };
  };

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
    config.common.default = "*";
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    ipafont
    kanji-stroke-order-font
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
  ];

  # Noctalia Cache
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
