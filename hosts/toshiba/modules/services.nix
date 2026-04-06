{ ... }:

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
}
