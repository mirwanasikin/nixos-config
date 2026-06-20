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

  # k3s
  services.k3s = {
    enable = false;
    role = "server";
  };

  # TailScale
  services.tailscale.enable = true;

  # Gitlab Runner
  services.gitlab-runner = {
    enable = true;
    configFile = "/etc/gitlab-runner/config.toml";
  };

  # Battery
  services.upower.enable = true;

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
