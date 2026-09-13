_:

{
  # Services
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    libinput.enable = true;

    # Udisks
    udisks2.enable = true;

    # Dbus
    dbus.enable = true;

    openssh.enable = false;

    # K3s
    k3s = {
      enable = false;
      role = "server";
    };

    # Tailscale
    tailscale.enable = true;

    gitlab-runner = {
      enable = true;
      configFile = "/etc/gitlab-runner/config.toml";
    };

    # Battery
    upower.enable = true;

    # GVFS
    gvfs.enable = true;
  };

  # Ollama
  # services.ollama = {
  #  enable = true;
  #   package = pkgs.ollama-cpu;
  # };

  # OpenWEB UI
  # services.open-webui = {
  #   enable = true;
  #   host = "127.0.0.1";
  #  port = 8080;
  #  environment = {
  #    ANONYMIZED_TELEMETRY = "False";
  #    DO_NOT_TRACK = "True";
  #    SCARF_NO_ANALYTICS = "True";
  #    OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #  };
  # } ;

  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "open-webui"
  #   ];
}
