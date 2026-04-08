{ pkgs, ... }:

{
  # Services
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.udisks2.enable = true;
  services.dbus.enable = true;
  services.openssh.enable = false;

  # Dunst
  systemd.user.services.dunst = {
    description = "Dunst notification daemon";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
  };

  # k3s
  services.k3s = {
    enable = true;
    role = "server";
  };
}
