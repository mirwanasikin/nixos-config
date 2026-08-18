{ ... }:

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
  };

  # Yazi
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  # Bat
  programs.bat.enable = true;

  # Lazygit
  programs.lazygit.enable = true;

  # Eza
  programs.eza.enable = true;

  # Btop
  programs.btop = {
    enable = true;
    extraConfig = ''
      theme_background = false
      vim_keys = true
      show_uptime = true
    '';
  };
  # k9s
  programs.k9s.enable = true;

}
