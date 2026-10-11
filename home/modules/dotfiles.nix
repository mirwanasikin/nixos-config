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
    yazi.enable = false;
    k9s.transparent = true;
    cava.transparent = true;
  };

  programs = {
    # Bat
    bat.enable = true;

    # Lazygit
    lazygit.enable = true;

    # Eza
    eza.enable = true;

    # Aerc
    aerc = {
      enable = true;
      extraConfig = {
        filters = {
          "text/plain" = "less";
          "text/html" = "w3m -T text/html";
        };
      };
    };

    # Cava
    cava.enable = true;

    # Mpv
    mpv.enable = true;

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

    # direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

}
