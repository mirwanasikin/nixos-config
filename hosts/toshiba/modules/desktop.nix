{ pkgs, ... }:

{
  # Sway
  programs.sway.enable = true;

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm;
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
  ];
}
