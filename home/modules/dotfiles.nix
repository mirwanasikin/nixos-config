_:

{
  # Catppuccin
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    starship.enable = false;
    gtk.icon.enable = false;
  };

  programs = {
    # Yazi
    yazi = {
      enable = true;
      shellWrapperName = "y";
    };

    # Bat
    bat.enable = true;

    # Lazygit
    lazygit.enable = true;

    # Eza
    eza.enable = true;

    # Btop
    btop = {
      enable = true;
      extraConfig = ''
        theme_background = false
        vim_keys = true
        show_uptime = true
      '';
    };

    # K9s
    k9s.enable = true;
  };

}
