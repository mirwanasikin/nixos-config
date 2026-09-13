_:

{
  services = {
    # Udiskie for Automount USB
    udiskie = {
      enable = true;
      automount = true;
      tray = "never";
    };

    # For Synchronize
    syncthing = {
      enable = true;
    };

    # Spotatui Background
    spotifyd = {
      enable = true;
      settings = {
        global = {
          device_name = "spotatui-headless";
          bitrate = 320;
          backend = "pulseaudio";
        };
      };
    };

  };
}
