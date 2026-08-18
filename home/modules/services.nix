{ ... }:

{
  services.udiskie = {
    enable = true;
    automount = true;
    tray = "never";
  };

  services.syncthing = {
    enable = true;
  };

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "spotatui-headless";
        bitrate = 320;
        backend = "pulseaudio";
      };
    };
  };
}
