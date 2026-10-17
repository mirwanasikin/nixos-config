{ pkgs, ... }:

{
  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.defaultSession = "niri";

  # noctalia-greeter
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 24;
      keyboard.layout = "us";
      appearance = {
        scheme = "Catppuccin";
      };
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  # Catppuccin
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    plymouth.enable = true;
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
}
